import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/features/therapy/data/models/ice_candidate_response.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../account/presentation/user_bloc/user_bloc.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());

  int _callerId = 0;
  int _calleeId = 0;
  SdpOffer? _offer;

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

  Future<void> startCall(int callerId, calleeId, SdpOffer? offer) async {
    _calleeId = calleeId;
    _callerId = callerId;
    _offer = offer;

    await Future.delayed(const Duration(milliseconds: 1));
    // initializing renderers
    localRTCVideoRenderer.initialize();
    remoteRTCVideoRenderer.initialize();
    // setup Peer Connection
    _setupPeerConnection();
    // _listenToPusher();
  }

  _setupPeerConnection() async {
    // create peer connection
    try {
      _rtcPeerConnection = await createPeerConnection({
        "iceServers": [
          {
            "url": "stun:global.stun.twilio.com:3478",
            "urls": "stun:global.stun.twilio.com:3478"
          },
          {
            "url": "turn:global.turn.twilio.com:3478?transport=udp",
            "username":
                "a433218b11c4ca840c61325423fbb7b79439319f02c2efd462ce66a5dc352bf9",
            "urls": "turn:global.turn.twilio.com:3478?transport=udp",
            "credential": "TOXPtZss6Qj7XWCj6mXFp2SskSRD3opkhDZSGojNdbI="
          },
          {
            "url": "turn:global.turn.twilio.com:3478?transport=tcp",
            "username":
                "a433218b11c4ca840c61325423fbb7b79439319f02c2efd462ce66a5dc352bf9",
            "urls": "turn:global.turn.twilio.com:3478?transport=tcp",
            "credential": "TOXPtZss6Qj7XWCj6mXFp2SskSRD3opkhDZSGojNdbI="
          },
          {
            "url": "turn:global.turn.twilio.com:443?transport=tcp",
            "username":
                "a433218b11c4ca840c61325423fbb7b79439319f02c2efd462ce66a5dc352bf9",
            "urls": "turn:global.turn.twilio.com:443?transport=tcp",
            "credential": "TOXPtZss6Qj7XWCj6mXFp2SskSRD3opkhDZSGojNdbI="
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
      _rtcPeerConnection!.onAddStream = (stream) {
        print('addStream: ' + stream.id);
        print(stream);
        remoteRTCVideoRenderer.srcObject = stream;
        logger.f('stream added');
        setState(() {});
      };
      logger.w('message');
      // listen for remotePeer mediaTrack event
      // _rtcPeerConnection!.onTrack = (event) {
      //   print('New track: ');
      //   _remoteRTCVideoRenderer.srcObject = event.streams[0];
      //   setState(() {});
      // };
      // get localStream
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': isAudioOn,
        'video': isVideoOn
            ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
            : false,
      });
      // add mediaTrack to peerConnection
      _localStream!.getTracks().forEach((track) {
        _rtcPeerConnection!.addTrack(track, _localStream!);
        logger.w('adding');
        setState(() {});
      });
      // set source for local video renderer
      localRTCVideoRenderer.srcObject = _localStream;
      setState(() {});
      _listenToPusher();

      print("Offer data");
      print(jsonEncode(_offer?.sdp));

      await _rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(_offer?.sdp, _offer?.type),
      );

      // create SDP answer
      RTCSessionDescription answer =
          await _rtcPeerConnection!.createAnswer({'offerToReceiveVideo': 1});

      // set SDP answer as localDescription for peerConnection
      _rtcPeerConnection!.setLocalDescription(answer);

      print("Anwer data");
      print(jsonEncode(answer.toMap()));

      // send SDP answer to remote peer
      _answerCall(_callerId, answer.toMap());
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }

  _leaveCall() {
    // Navigator.pop(context);
  }

  toggleMic() {
    // change status
    isAudioOn = !isAudioOn;
    // enable or disable audio track
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });

    logger.w(isAudioOn);
    setState(() {});
  }

  toggleCamera() {
    // change status
    isVideoOn = !isVideoOn;
    // enable or disable video track
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
    setState(() {});
  }

  switchCamera() {
    // change status
    isFrontCameraSelected = !isFrontCameraSelected;
    // switch camera
    _localStream?.getVideoTracks().forEach((track) {
      // ignore: deprecated_member_use
      track.switchCamera();
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

  onEventReceived(event) {
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
  }

  onSubscriptionError(message, d) {}

  void _answerCall(int callerId, map) async {
    try {
      var networkService = injector.get<NetworkService>();
      var body = {
        "callerId": callerId,
        "calleeId": _calleeId,
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
      logger.e(e.toString(), stackTrace: stack);
    }
  }

  void _pushCandidate(int callerId, candidate) async {
    try {
      var networkService = injector.get<NetworkService>();
      var body = {
        "callerId": callerId,
        "calleeId": _calleeId,
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

  void acceptCall() {
    emit(AcceptCallState());
  }
}
