import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class TherapistVideoWidget extends StatefulWidget {
  const TherapistVideoWidget(
      {super.key, required this.remoteRenderer,});

  final RTCVideoRenderer remoteRenderer;

  @override
  State<TherapistVideoWidget> createState() => _TherapistVideoWidgetState();
}

class _TherapistVideoWidgetState extends State<TherapistVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            child: RTCVideoView(

              widget.remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
          Positioned(
              bottom: 16,
              left: 16,
              child: Row(
                children: [
                  const TextView(
                    text: 'Therapist',
                    fontWeight: FontWeight.w600,
                    color: Pallets.white,
                  ),
                  8.horizontalSpace,
                  ImageWidget(imageUrl: Assets.images.pngs.speaking.path)
                ],
              ))
        ],
      ),
    );
  }
}
