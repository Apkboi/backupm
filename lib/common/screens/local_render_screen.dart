import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mentra/core/di/injector.dart';

class LocalRender extends StatefulWidget {
  const LocalRender({super.key});

  @override
  State<LocalRender> createState() => _LocalRenderState();
}

class _LocalRenderState extends State<LocalRender> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 30),
      () async {
        localRTCVideoRenderer.initialize();

        // get localStream
        _localStream = await navigator.mediaDevices.getUserMedia({
          'audio': true,
          'video': {
            'facingMode': 'user',
            'mandatory': {
              'minWidth': '640',
              'minHeight': '480',
              'minFrameRate': '30',
            },
            "echoCancellation": true,
          }
        });

        // set source for local video renderer
        setState(() {
          localRTCVideoRenderer.srcObject = _localStream;
        });
      },
    );

    super.initState();
  }

  final localRTCVideoRenderer = RTCVideoRenderer();

  // mediaStream for localPeer
  MediaStream? _localStream;

  @override
  Widget build(BuildContext context) {
    logger.w(localRTCVideoRenderer.videoHeight);
    logger.w(localRTCVideoRenderer.videoWidth);
    logger.w(localRTCVideoRenderer.muted);
    return RTCVideoView(
      localRTCVideoRenderer,
      filterQuality: FilterQuality.medium,
      mirror: true,

      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
    );
  }
}
