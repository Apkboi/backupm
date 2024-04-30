import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/common/widgets/user_image_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/gen/assets.gen.dart';

class IncomingCallScreen extends StatefulWidget {
  const IncomingCallScreen({super.key});

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          30.verticalSpace,
          Center(child: UserCircleImage(url: Assets.images.pngs.avatar3.path)),
          10.verticalSpace,
          TextView(text: 'Therapist'),
          5.verticalSpace,
          TextView(text: 'Incoming call'),
          Expanded(child: Container()),
          Row(
            children: [
              CircleAvatar(
                // child: Icon,
              )
            ],
          )
        ],
      ),
    );
  }
}
