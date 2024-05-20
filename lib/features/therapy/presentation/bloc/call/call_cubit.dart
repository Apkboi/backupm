import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/core/services/sentory/sentory_service.dart';
import 'package:mentra/features/therapy/data/models/ice_candidate_response.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/dormain/repository/call_repository.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../account/presentation/user_bloc/user_bloc.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit(this._callRepository) : super(CallInitial());
  final CallRepository _callRepository;

  int _callerId = 0;
  int _calleeId = 0;
  dynamic _sessionId;
  SdpOffer? _offer;
  Caller? therapist;
  dynamic isCallActive = true;

  // videoRenderer for localPeer
  final localRTCVideoRenderer = RTCVideoRenderer();

  // videoRenderer for remotePeer
  final remoteRTCVideoRenderer = RTCVideoRenderer();

  // mediaStream for localPeer
  MediaStream? _localStream;

  // RTC peer connection
  RTCPeerConnection? _rtcPeerConnection;

  // list of rtcCandidates to be sent over signalling
  List<RTCIceCandidate> rtcIceCandidates = [];

  // media status
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  var retriedTimes = 0;

  bool shouldEndCall() {
    if (retriedTimes < 4) {
      retriedTimes += 1;

      return false;
    } else {
      return true;
    }
  }

  void setState(dynamic fn) {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        emit(CallStateUpdated());
      },
    );
  }

  Future<void> startCall(
    int callerId,
    calleeId,
    SdpOffer? offer,
    Caller? caller,
    dynamic sessionId,
  ) async {
    isCallActive = true;
    emit(CallConnectingState());
    _calleeId = calleeId;
    _callerId = callerId;
    _offer = offer;
    _sessionId = sessionId;
    therapist = caller;

    await Future.delayed(const Duration(milliseconds: 1));
    // initializing renderers
    localRTCVideoRenderer.initialize();
    remoteRTCVideoRenderer.initialize();
    setState(null);

    if (_offer == null) {
      await _getOfferFromRemote();
      setState(null);
    }
    // setup Peer Connection
    _setupPeerConnection();
    // _listenToPusher();
  }

  _setupPeerConnection() async {
    // create peer connection
    try {
      _rtcPeerConnection = await createPeerConnection({
        'iceServers': [
          {
            'urls': [
              'stun:stun1.l.google.com:19302',
              // Public STUN server (consider private for production)
              'stun:stun.rtc.yourmentra.com',
              // Your TURN server's STUN endpoint (if available)
            ]
          },
          {
            'urls': [
              'turn:turn.rtc.yourmentra.com', // Your TURN server URL
            ],
            'username': 'turn',
            'credential': 'Turn09865', // Replace with your actual credentials
          }
        ]
      });
      _rtcPeerConnection!.onIceCandidate = (candidate) {
        if (candidate.candidate != null) {
          _pushCandidate(_callerId, {
            'candidate': candidate.candidate,
            'sdpMid': candidate.sdpMid.toString(),
            'sdpMlineIndex': candidate.sdpMLineIndex,
          });
        }
      };

      _rtcPeerConnection!.onIceConnectionState = (state) {
        if (state == RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
            state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
          Debouncer(milliseconds: 5000).run(() {
            if (shouldEndCall()) {
              endCall();
            } else {
              retriedTimes = 0;
              emit(CallReConnectingState());
            }
          });
        }
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
          isVideoOn = true;
          emit(CallConnectedState());
        }
      };

      _rtcPeerConnection!.onTrack = (event) {
        remoteRTCVideoRenderer.srcObject = event.streams[0];
        setState(() {});
      };

      // get localStream
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': isAudioOn,
        'video': isVideoOn
            ? {
                'facingMode': isFrontCameraSelected ? 'user' : 'environment',
                'mandatory': {
                  'minWidth': '640',
                  'minHeight': '480',
                  'minFrameRate': '30',
                },
                "echoCancellation": true,
              }
            : {},
        "echoCancellation": true,
      });

      // add mediaTrack to peerConnection
      _localStream!.getTracks().forEach((track) async {
        await _rtcPeerConnection!.addTrack(track, _localStream!);
        setState(() {});
      });

      // set source for local video renderer

      localRTCVideoRenderer.srcObject = _localStream;

      setState(() {});
      _listenToPusher();

      await _rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(_offer?.sdp, _offer?.type),
      );

      // create SDP answer
      RTCSessionDescription answer =
          await _rtcPeerConnection!.createAnswer({'offerToReceiveVideo': 1});

      // set SDP answer as localDescription for peerConnection
      _rtcPeerConnection!.setLocalDescription(answer);

      // send SDP answer to remote peer
      await _answerCall(_callerId, answer.toMap());
    } catch (e, stack) {
      if (shouldEndCall()) {
        emit(CallConnectingFailedState());
      } else {
        _setupPeerConnection();
        emit(CallReConnectingState());
      }
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }

  void _createOffer() async {
    RTCSessionDescription offer =
        await _rtcPeerConnection!.createOffer({'offerToReceiveVideo': 1});
    _rtcPeerConnection!.setLocalDescription(offer);
    await _offerCall(_callerId, offer.toMap());
  }

  toggleMic() {
    // change status
    isAudioOn = !isAudioOn;
    // enable or disable audio track
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });
    _callAction("audioStateChanged", isAudioOn ? "enabled" : "disabled");
    setState(() {});
  }

  toggleCamera() {
    // change status
    isVideoOn = !isVideoOn;
    // enable or disable video track

    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });
    _callAction("videoStateChanged", isVideoOn ? "enabled" : "disabled");
    setState(() {});
  }

  switchCamera() {
    // change status
    isFrontCameraSelected = !isFrontCameraSelected;
    // switch camera
    _localStream?.getVideoTracks().forEach((track) {
      // ignore: deprecated_member_use
      track.switchCamera();
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });
    setState(() {});
  }

  void dispose() {
    localRTCVideoRenderer.dispose();
    remoteRTCVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    CallKitService.instance.endAllCalls();
  }

  void _listenToPusher() async {
    logger.w('listening');

    try {
      var pusherService = await PusherChannelService.getInstance;
      var pusher = await pusherService.getClient;
      if (pusher != null) {
        logger.w('connecting');
        if (!pusher.channels
            .containsKey(injector.get<UserBloc>().userChannel)) {
          PusherChannel channel = await pusher.subscribe(
            channelName: injector.get<UserBloc>().userChannel,
            onSubscriptionError: (message, d) =>
                onSubscriptionError(message, d),
            onSubscriptionSucceeded: (data) {
              // log('subscribed');
              // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
              // return data;a
            },
            onEvent: (event) => onEventReceived(event),
          );
          logger.w('connected');
        } else {
          logger.w('connected2');
          pusher.getChannel(injector.get<UserBloc>().userChannel)?.onEvent =
              onEventReceived;
        }

        await pusher.connect();
      }
    } catch (e, s) {
      SentryService.captureException(e, stackTrace: s);
    }
  }

  onEventReceived(event) async {
    // injector.get<PusherCubit>().triggerPusherEvent(event);
    logger.w('Event from server:$event');

    var data = (event as PusherEvent).data;
    if ((event).eventName == 'IceCandidate') {
      IceCandidateResponse iceCandidateResponse =
          IceCandidateResponse.fromJson(jsonDecode(data));

      // add iceCandidate
      _rtcPeerConnection!.addCandidate(RTCIceCandidate(
        iceCandidateResponse.iceCandidate.candidate,
        iceCandidateResponse.iceCandidate.sdpMid,
        iceCandidateResponse.iceCandidate.sdpMLineIndex,
      ));
      logger.i("Added iceCandidate to rtcPeerConnection");
      logger.i(iceCandidateResponse.iceCandidate.toJson());
    }

    if ((event).eventName == 'callAnswered') {
      IncomingCallResponse answerResponse =
          IncomingCallResponse.fromJson(jsonDecode(data));
      await _rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(
            answerResponse.sdpAnswer!.sdp, answerResponse.sdpAnswer!.type),
      );
      emit(CallConnectedState());
    }

    if ((event).eventName == 'callAction') {
      IncomingCallResponse response =
          IncomingCallResponse.fromJson(jsonDecode(data));
      emit(CallActionState(response));
    }

    if ((event).eventName == 'callEnded') {
      // var currentCall = await CallKitService.instance.getCurrentCall();
      CallKitService.instance.endAllCalls();
      if (isCallActive) {
        emit(CallEndedState());
        isCallActive = false;
        _closeAllCameras();
      }
    }
  }

  onSubscriptionError(message, d) {}

  _offerCall(int callerId, map) async {
    try {
      _callRepository.offerCall(callerId, _calleeId, _sessionId, map);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  _callAction(String action, String value) async {
    try {
      await _callRepository.callAction(
          _calleeId, _callerId, _sessionId.toString(), action, value);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  _answerCall(int callerId, map) async {
    try {
      await _callRepository.answerCall(
          _callerId, map, _calleeId.toString(), _sessionId.toString());
      _createOffer();

      _callAction("videoStateChanged", isVideoOn ? "enabled" : "disabled");
      _callAction("audioStateChanged", isAudioOn ? "enabled" : "disabled");
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);

      rethrow;
    }
  }

  endCall() async {
    if (isCallActive) {
      emit(EndCallLoadingState());

      try {
        CallKitService.instance.endAllCalls();
        _callRepository.endCall(
            _callerId, _calleeId, _sessionId.toString(), _calleeId.toString());

        _closeAllCameras();
      } catch (e, stack) {
        emit(EndCallFailedState(e.toString()));
        logger.e(e.toString(), stackTrace: stack);
      }
    }
  }

  void _pushCandidate(int callerId, candidate) async {
    try {
      await _callRepository.pushCandidate(
          callerId, candidate, _calleeId.toString(), _sessionId.toString());
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  void acceptCall(
    String descriptionId,
  ) {
    emit(AcceptCallState(descriptionId));
  }

  Future _getOfferFromRemote() async {
    logger.w('getting offer from remote');
    try {
      var offerResponse = await _callRepository.getOffer(_callerId);
      _offer = offerResponse.data.sdpOffer;
      _callerId = offerResponse.data.callerId;
      _sessionId = offerResponse.data.therapySessionId;
      therapist = offerResponse.data.therapist;

      return;
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  void _closeAllCameras() {
    _rtcPeerConnection?.close();
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = false;
      isVideoOn = false;
    });
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = false;
      isAudioOn = false;
    });
    remoteRTCVideoRenderer.dispose();
  }

  void reviewTherapist(Caller therapist, String sessionId) {
    emit(ReviewTherapistCallState(therapist, sessionId));
  }

  void leaveCallScreen() {
    emit(LeaveCallState());
  }
}
