import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';

import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/features/therapy/data/models/get_offer_response.dart';
import 'package:mentra/features/therapy/data/models/ice_candidate_response.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../account/presentation/user_bloc/user_bloc.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());

  int _callerId = 0;
  int _calleeId = 0;
  dynamic _sessionId;
  SdpOffer? _offer;
  Caller? therapist;

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

  void setState(fn) {
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
    dynamic sessionId,
  ) async {
    emit(CallConnectingState());
    _calleeId = calleeId;
    _callerId = callerId;
    _offer = offer;
    _sessionId = sessionId;

    await Future.delayed(const Duration(milliseconds: 1));
    // initializing renderers
    localRTCVideoRenderer.initialize();
    remoteRTCVideoRenderer.initialize();

    if (_offer == null) {
      _getOfferFromRemote();
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
          endCall();
        }
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
          emit(CallConnectedState());
        }
      };
      // _rtcPeerConnection!.onAddStream = (stream) {
      //   print('addStream: ' + stream.id);
      //   print(stream);
      //   remoteRTCVideoRenderer.srcObject = stream;
      //   logger.f('stream added');
      //   setState(() {});
      // };
      // listen for remotePeer mediaTrack event
      _rtcPeerConnection!.onTrack = (event) {
        remoteRTCVideoRenderer.srcObject = event.streams[0];
        setState(() {});
      };
      // get localStream
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': isAudioOn,
        'video': isVideoOn
            ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
            : false,
        "echoCancellation": true
      });
      // add mediaTrack to peerConnection
      _localStream!.getTracks().forEach((track) {
        _rtcPeerConnection!.addTrack(track, _localStream!);
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

      _callAction("videoStateChanged", isVideoOn ? "enabled" : "disabled");
      _callAction("audioStateChanged", isAudioOn ? "enabled" : "disabled");


      _createOffer();
    } catch (e, stack) {
      emit(CallConnectingFailedState());
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

  _leaveCall() {
    // Navigator.pop(context);
  }

  toggleMic() {
    // remoteRTCVideoRenderer.audioOutput('deviceId')
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
  }

  void _listenToPusher() async {
    logger.w('listenening');

    var pusherService = await PusherChannelService.getInstance;
    var pusher = await pusherService.getClient;
    if (pusher != null) {
      logger.w('connecting');
      if (!pusher.channels.containsKey(injector.get<UserBloc>().userChannel)) {
        PusherChannel channel = await pusher.subscribe(
          channelName: injector.get<UserBloc>().userChannel,
          onSubscriptionError: (message, d) => onSubscriptionError(message, d),
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
  }

  onEventReceived(event) async {
    // injector.get<PusherCubit>().triggerPusherEvent(event);
    logger.w('Event from server:$event');

    var data = (event as PusherEvent).data;
    if ((event).eventName == 'IceCandidate') {
      IceCandidateResponse iceCandidateResponse =
          IceCandidateResponse.fromJson(jsonDecode(data));
      // String candidate = data["iceCandidate"]["candidate"];
      // String sdpMid = data["iceCandidate"]["sdpMid"];
      // int sdpMLineIndex = data["iceCandidate"]["sdpMLineIndex"];
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
      CallKitService.instance.endCall();
      emit(CallEndedState());
    }
  }

  onSubscriptionError(message, d) {}

  _offerCall(int callerId, map) async {
    try {
      var networkService = injector.get<NetworkService>();
      var body = {
        "callerId": _calleeId,
        "calleeId": callerId,
        "therapy_session_id": _sessionId,
        "sdpOffer": base64.encode(utf8.encode(jsonEncode(map))),
      };

      logger.w('Pushing answer');
      logger.w(body);

      var respose = await networkService.call(
          'https://staging.app.yourmentra.com/api/v1/webrtc/make-call',
          RequestMethod.post,
          data: body);
      logger.w(respose.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  _callAction(String action, String value) async {
    try {
      var networkService = injector.get<NetworkService>();
      var body = {
        "callerId": _calleeId,
        "calleeId": _callerId,
        "therapy_session_id": _sessionId,
        "action": action,
        "value": value,
      };

      var respose = await networkService.call(
          'https://staging.app.yourmentra.com/api/v1/webrtc/call-action',
          RequestMethod.post,
          data: body);
      logger.w(respose.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  _answerCall(int callerId, map) async {
    try {
      var networkService = injector.get<NetworkService>();

      var body = {
        "callerId": callerId,
        "calleeId": _calleeId,
        "therapy_session_id": _sessionId,
        "sdpAnswer": base64.encode(utf8.encode(jsonEncode(map))),
      };

      logger.w('Pushing answer');
      logger.w(body);
      var respose = await networkService.call(
          'https://staging.app.yourmentra.com/api/v1/webrtc/answer-call',
          RequestMethod.post,
          data: body);
      logger.w(respose.data);
    } catch (e, stack) {
      // TODO: Emit Call Failed State
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  endCall() async {
    emit(EndCallLoadingState());
    try {
      var networkService = injector.get<NetworkService>();

      var body = {
        "callerId": _callerId,
        "calleeId": _calleeId,
        "sender": _calleeId,
        "therapy_session_id": _sessionId,
      };

      // logger.w('Pushing answer');
      logger.w(body);
      CallKitService.instance.endCall();
      var respose = await networkService.call(
          'https://staging.app.yourmentra.com/api/v1/webrtc/end-call',
          RequestMethod.post,
          data: body);
      logger.w(respose.data);
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
    } catch (e, stack) {
      // TODO: Emit Call Failed State
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  void _pushCandidate(int callerId, candidate) async {
    try {
      var networkService = injector.get<NetworkService>();
      var body = {
        "callerId": callerId,
        "calleeId": _calleeId,
        "therapy_session_id": _sessionId,
        "iceCandidate": base64.encode(utf8.encode(jsonEncode(candidate))),
        "sender": "user"
      };
      logger.w('Pushing candidate');
      logger.w(body);
      var respose = await networkService.call(
          'https://staging.app.yourmentra.com/api/v1/webrtc/ice-candidate',
          RequestMethod.post,
          data: body);
      logger.w(respose.data);
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
    try {
      var networkService = injector.get<NetworkService>();
      // logger.w(body);
      // var body = {
      //   "callerId": _callerId,
      //   "calleeId": _calleeId,
      //   // "iceCandidate": base64.encode(utf8.encode(jsonEncode(candidate))),
      //   // "sender": "user"
      // };

      logger.w('Pushing candidate');

      var respose = await networkService.call(
        'https://staging.app.yourmentra.com/api/v1/webrtc/get-offer/:$_callerId',
        RequestMethod.get,
        // data: body
      );
      logger.w(respose.data);
      var offerResponse = GetOfferResponse.fromJson(respose.data);
      _offer = offerResponse.data.payload.sdpOffer;
      _callerId = offerResponse.data.payload.callerId;
      // _sessionId = offerResponse.data.payload.
      // therapist = offerResponse.data.payload.
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
    }
  }
}
