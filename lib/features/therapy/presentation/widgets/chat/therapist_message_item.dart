import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';
import 'package:mentra/gen/assets.gen.dart';

class TherapistMessageItem extends StatefulWidget {
  const TherapistMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);
  final TherapyChatMessage message;

  @override
  State<TherapistMessageItem> createState() => _TherapistMessageItemState();
}

class _TherapistMessageItemState extends State<TherapistMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 12.h,
              ),
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 13,
                  child: ImageWidget(
                    imageUrl: Assets.images.pngs.launcherIcon.path,
                    fit: BoxFit.cover,

                    width: 35,
                    height: 60,
                    // size: 40,
                  )),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 0.75.sw,
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ...List.generate(
                      1,
                      (index) => ChatBubble(
                        // margin: EdgeInsets.zero,
                        padding: const EdgeInsets.only(
                            right: 8, bottom: 0, left: 15, top: 5),
                        backGroundColor: Pallets.navy,
                        clipper: ChatBubbleClipper3(
                            type: BubbleType.receiverBubble,
                            nipSize: 5,
                            radius: 15),
                        child: Container(
                          padding: null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextView(
                                  text: widget.message
                                      .toString()
                                      .trim(),
                                  lineHeight: 1.5,
                                  color: Pallets.white,
                                  fontSize: 15.sp,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w500),
                              8.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(TimeUtil.formatTime(widget.message.time..toLocal()),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Pallets.navy,
                          fontWeight: FontWeight.w600,
                        )),
                    6.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
