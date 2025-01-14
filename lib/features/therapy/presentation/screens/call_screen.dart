// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:mentra/core/di/injector.dart';
// import 'package:mentra/core/services/network/network_service.dart';
// import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
// import 'package:mentra/core/services/signalling_service/signalling.service.dart';
// import 'package:mentra/features/therapy/data/models/ice_candidate_response.dart';
// import 'package:mentra/features/therapy/data/models/incoming_response.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:sdp_transform/sdp_transform.dart';
//
// class CallScreen extends StatefulWidget {
//   final String callerId, calleeId;
//   final SdpOffer? offer;
//
//   const CallScreen({
//     super.key,
//     this.offer,
//     required this.callerId,
//     required this.calleeId,
//   });
//
//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }
//
// class _CallScreenState extends State<CallScreen> {
//   // socket instance
//   final socket = SignallingService.instance.socket;
//
//   // videoRenderer for localPeer
//   final _localRTCVideoRenderer = RTCVideoRenderer();
//
//   // videoRenderer for remotePeer
//   final _remoteRTCVideoRenderer = RTCVideoRenderer();
//
//   // mediaStream for localPeer
//   MediaStream? _localStream;
//
//   // RTC peer connection
//   RTCPeerConnection? _rtcPeerConnection;
//
//   // list of rtcCandidates to be sent over signalling
//   List<RTCIceCandidate> rtcIceCandidates = [];
//
//   // media status
//   bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
//
//   @override
//   void initState() {
//     // initializing renderers
//     _localRTCVideoRenderer.initialize();
//     _remoteRTCVideoRenderer.initialize();
//
//     // setup Peer Connection
//     _setupPeerConnection();
//     // _listenToPusher();
//     super.initState();
//   }
//
//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }
//
//   _setupPeerConnection() async {
//     var status = await Permission.camera.status;
//     // create peer connection
//     _rtcPeerConnection = await createPeerConnection({
//       'iceServers': [
//         {
//           'urls': [
//             'stun:stun1.l.google.com:19302',
//           ]
//         },
//         {
//           'urls': [
//             'turn:turn.rtc.yourmentra.com',
//           ],
//           'username': 'turn',
//           'credential': 'Turn09865',
//         }
//       ]
//     });
//
//     _rtcPeerConnection!.onIceCandidate = (candidate) {
//       if (candidate.candidate != null) {
//         // print("My peer connection");
//         // rtcIceCandidates.add(e);
//         // print(rtcIceCandidates.length);
//         _pushCandidate(widget.callerId, {
//           'candidate': candidate.candidate,
//           'sdpMid': candidate.sdpMid.toString(),
//           'sdpMlineIndex': candidate.sdpMLineIndex,
//         });
//       }
//     };
//
//     _rtcPeerConnection!.onAddStream = (stream) {
//       print('addStream: ' + stream.id);
//       print(stream);
//       _remoteRTCVideoRenderer.srcObject = stream;
//       setState(() {});
//     };
//
//     // listen for remotePeer mediaTrack event
//     // _rtcPeerConnection!.onTrack = (event) {
//     //   print('New track: ');
//     //   _remoteRTCVideoRenderer.srcObject = event.streams[0];
//     //   setState(() {});
//     // };
//
//     // get localStream
//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'audio': isAudioOn,
//       'video': isVideoOn
//           ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
//           : false,
//     });
//
//     // add mediaTrack to peerConnection
//     _localStream!.getTracks().forEach((track) {
//       _rtcPeerConnection!.addTrack(track, _localStream!);
//     });
//
//     // set source for local video renderer
//     _localRTCVideoRenderer.srcObject = _localStream;
//     setState(() {});
//
//     // _listenToPusher();
//     // listen for Remote IceCandidate
//     // socket!.on("IceCandidate", (data) {
//     //   String candidate = data["iceCandidate"]["candidate"];
//     //   String sdpMid = data["iceCandidate"]["id"];
//     //   int sdpMLineIndex = data["iceCandidate"]["label"];
//     //
//     //   // add iceCandidate
//     //   _rtcPeerConnection!.addCandidate(RTCIceCandidate(
//     //     candidate,
//     //     sdpMid,
//     //     sdpMLineIndex,
//     //   ));
//     // });
//
//     // set SDP offer as remoteDescription for peerConnection
//     await _rtcPeerConnection!.setRemoteDescription(
//       RTCSessionDescription(widget.offer?.sdp, widget.offer?.type),
//     );
//     // create SDP answer
//     RTCSessionDescription answer =
//         await _rtcPeerConnection!.createAnswer({'offerToReceiveVideo': 1});
//     // set SDP answer as localDescription for peerConnection
//     _rtcPeerConnection!.setLocalDescription(answer);
//     // send SDP answer to remote peer over signalling
//     // socket!.emit("answerCall", {
//     //   "callerId": widget.callerId,
//     //   "sdpAnswer": answer.toMap(),
//     // });
//
//     _answerCall(widget.callerId, answer.toMap());
//
//     // print("Candidates count");
//     // print(rtcIceCandidates.length);
//
//     // for (RTCIceCandidate candidate in rtcIceCandidates) {
//     //   print('pushing candidate to stream');
//
//     //   _pushCandidate(widget.callerId, {
//     //     'candidate': candidate.candidate,
//     //     'sdpMid': candidate.sdpMid.toString(),
//     //     'sdpMlineIndex': candidate.sdpMLineIndex,
//     //   });
//     // }
//   }
//
//   _leaveCall() {
//     Navigator.pop(context);
//   }
//
//   _toggleMic() {
//     // change status
//     isAudioOn = !isAudioOn;
//     // enable or disable audio track
//     _localStream?.getAudioTracks().forEach((track) {
//       track.enabled = isAudioOn;
//     });
//     setState(() {});
//   }
//
//   _toggleCamera() {
//     // change status
//     isVideoOn = !isVideoOn;
//
//     // enable or disable video track
//     _localStream?.getVideoTracks().forEach((track) {
//       track.enabled = isVideoOn;
//     });
//     setState(() {});
//   }
//
//   _switchCamera() {
//     // change status
//     isFrontCameraSelected = !isFrontCameraSelected;
//
//     // switch camera
//     _localStream?.getVideoTracks().forEach((track) {
//       // ignore: deprecated_member_use
//       track.switchCamera();
//     });
//     setState(() {});
//   }
//
//   void _createOffer() async {
//     RTCSessionDescription description =
//         await _rtcPeerConnection!.createOffer({'offerToReceiveVideo': 1});
//     var session = parse(description.sdp.toString());
//     log(json.encode(session));
//     // _offer = true;
//     _rtcPeerConnection!.setLocalDescription(description);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         title: const Text("P2P Call App"),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Stack(children: [
//                 RTCVideoView(
//                   _remoteRTCVideoRenderer,
//                   objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                 ),
//                 Positioned(
//                   right: 20,
//                   bottom: 20,
//                   child: SizedBox(
//                     height: 150,
//                     width: 120,
//                     child: RTCVideoView(
//                       _localRTCVideoRenderer,
//                       mirror: isFrontCameraSelected,
//                       objectFit:
//                           RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(
//                     icon: Icon(isAudioOn ? Icons.mic : Icons.mic_off),
//                     onPressed: _toggleMic,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.call_end),
//                     iconSize: 30,
//                     onPressed: _leaveCall,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.cameraswitch),
//                     onPressed: _switchCamera,
//                   ),
//                   IconButton(
//                     icon: Icon(isVideoOn ? Icons.videocam : Icons.videocam_off),
//                     onPressed: _toggleCamera,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _localRTCVideoRenderer.dispose();
//     _remoteRTCVideoRenderer.dispose();
//     _localStream?.dispose();
//     _rtcPeerConnection?.dispose();
//     super.dispose();
//   }
//
//   void _listenToPusher() async {
//     var pusherService = await PusherChannelService.getInstance;
//     var pusher = await pusherService.getClient;
//     if (pusher != null) {
//       logger.w('connecting');
//       if (!pusher.channels.containsKey('user_2')) {
//         PusherChannel channel = await pusher.subscribe(
//           channelName: 'user_2',
//           onSubscriptionError: (message, d) => onSubscriptionError(message, d),
//           onSubscriptionSucceeded: (data) {
//             // log('subscribed');
//             // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
//             // return data;a
//           },
//           onEvent: (event) => onEventReceived(event),
//         );
//         logger.w('connected');
//       } else {
//         logger.w('connected2');
//
//         pusher.getChannel('user_2')?.onEvent = onEventReceived;
//       }
//
//       await pusher.connect();
//     }
//   }
//
//   onEventReceived(event) {
//     logger.w('Event from server:$event');
//     var data = (event as PusherEvent).data;
//
//     if ((event).eventName == 'IceCandidate') {
//       IceCandidateResponse iceCandidateResponse =
//           IceCandidateResponse.fromJson(jsonDecode(data));
//
//       // String candidate = data["iceCandidate"]["candidate"];
//       // String sdpMid = data["iceCandidate"]["sdpMid"];
//       // int sdpMLineIndex = data["iceCandidate"]["sdpMLineIndex"];
//
//       // add iceCandidate
//       _rtcPeerConnection!.addCandidate(RTCIceCandidate(
//         iceCandidateResponse.iceCandidate.candidate,
//         iceCandidateResponse.iceCandidate.sdpMid,
//         iceCandidateResponse.iceCandidate.sdpMLineIndex,
//       ));
//
//       logger.i("Added iceCandidate to rtcPeerConnection");
//     }
//   }
//
//   onSubscriptionError(message, d) {}
//
//   void _answerCall(String callerId, map) async {
//     try {
//       var networkService = injector.get<NetworkService>();
//       var body = {
//         "callerId": widget.callerId,
//         "calleeId": widget.calleeId,
//         "sdpAnswer": map,
//       };
//
//       logger.w('Pushing answer');
//       logger.w(body);
//
//       var respose = await networkService.call(
//           // 'https://webrtc.yourmentra.com/answerCall',
//           'https://staging.app.yourmentra.com/api/v1/webrtc/answer-call',
//           RequestMethod.post,
//           data: body);
//       logger.w(respose.data);
//     } catch (e, stack) {
//       logger.e(e.toString(), stackTrace: stack);
//     }
//   }
//
//   void _pushCandidate(String callerId, candidate) async {
//     try {
//       var networkService = injector.get<NetworkService>();
//       var body = {
//         "callerId": widget.callerId,
//         "calleeId": widget.calleeId,
//         "iceCandidate": candidate,
//         "sender": "user"
//       };
//
//       logger.w('Pushing candidate');
//       logger.w(body);
//
//       var respose = await networkService.call(
//           // 'https://webrtc.yourmentra.com/IceCandidate',
//           'https://staging.app.yourmentra.com/api/v1/webrtc/ice-candidate',
//           RequestMethod.post,
//           data: body);
//       logger.w(respose.data);
//     } catch (e, stack) {
//       logger.e(e.toString(), stackTrace: stack);
//     }
//   }
// }
