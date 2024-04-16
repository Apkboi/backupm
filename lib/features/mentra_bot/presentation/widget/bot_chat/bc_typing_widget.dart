import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class BotTypingWidget extends StatefulWidget {
  const BotTypingWidget({super.key});

  @override
  State<BotTypingWidget> createState() => _BotTypingWidgetState();
}

class _BotTypingWidgetState extends State<BotTypingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.transparent,
            child: ImageWidget(
              imageUrl: Assets.images.pngs.launcherIcon.path,
              fit: BoxFit.cover,
              width: 35,
              height: 35,
              // size: 40,
            ),
          ),
        ),
        Column(
          children: [
            ChatBubble(
              // padding: const EdgeInsets.only(right: 8, bottom: 0, left: 15, top: 5),
              backGroundColor: Pallets.navy,
              clipper: ChatBubbleClipper3(
                  type: BubbleType.receiverBubble, nipSize: 5, radius: 15),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                child: SizedBox(
                  width: 35.w,
                  height: 5.h,
                  child: const SpinKitThreeBounce(
                    color: Pallets.white,
                    size: 14.0,
                  ),
                ),
              ),
            ),
            8.verticalSpace
          ],
        )
      ],
    );
  }
}
