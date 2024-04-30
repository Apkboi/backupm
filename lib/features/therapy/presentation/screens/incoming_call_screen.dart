import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/common/widgets/user_image_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/gen/assets.gen.dart';

class IncomingCallScreen extends StatefulWidget {
  const IncomingCallScreen(
      {super.key, required this.callerId, required this.calleeId, this.offer});

  final String callerId, calleeId;
  final SdpOffer? offer;

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCBF5E5),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 100.verticalSpace,
            Center(
                child: ImageWidget(
              imageUrl: Assets.images.pngs.avatar3.path,
              size: 120,
            )),
            10.verticalSpace,
            const TextView(
              text: 'Therapist',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            5.verticalSpace,
            const TextView(text: 'Incoming call'),
            70.verticalSpace,
            // Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _answerCall(context);
                    },
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Pallets.successGreen,
                          child: Icon(Icons.phone_rounded),
                        ),
                        5.verticalSpace,
                        const TextView(
                          text: 'Accept',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Pallets.red,
                          child:
                              ImageWidget(imageUrl: Assets.images.svgs.endCall),
                        ),
                        5.verticalSpace,
                        const TextView(
                          text: 'Decline',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _answerCall(BuildContext context) {
    context.pushReplacementNamed(PageUrl.therapyCallScreen, queryParameters: {
      PathParam.calleeId: '2',
      PathParam.callerId: widget.callerId,
      PathParam.offer: jsonEncode(widget.offer?.toJson()),
    });
  }
}
