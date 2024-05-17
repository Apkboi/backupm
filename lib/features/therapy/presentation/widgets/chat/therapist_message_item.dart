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
    required this.showImage,
  }) : super(key: key);
  final TherapyChatMessage message;
  final bool showImage;

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
            // widget.showImage
            //     ? Padding(
            //         padding: EdgeInsets.only(
            //           bottom: 12.h,
            //         ),
            //         child: CircleAvatar(
            //             backgroundColor: Colors.transparent,
            //             radius: 13,
            //             child: ImageWidget(
            //               imageUrl: Assets.images.pngs.launcherIcon.path,
            //               fit: BoxFit.cover,
            //
            //               width: 35,
            //               height: 60,
            //               // size: 40,
            //             )),
            //       )
            //     : 35.horizontalSpace,
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
                      (index) {
                        if (widget.showImage) {
                          return _BubbleBorder(
                              child: MessageBody(message: widget.message));
                        }

                        return _CircularBorder(
                            child: MessageBody(message: widget.message));
                      },
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

class _CircularBorder extends StatelessWidget {
  const _CircularBorder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 0.7.sw),
      padding: const EdgeInsets.only(right: 8, bottom: 0, left: 8, top: 5),
      decoration: BoxDecoration(
          color: Pallets.navy, borderRadius: BorderRadius.circular(10)),
      child: child,
      // backGroundColor: Pallets.navy,
    );
  }
}

class _BubbleBorder extends StatelessWidget {
  const _BubbleBorder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      // margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(right: 8, bottom: 0, left: 15, top: 5),
      backGroundColor: Pallets.navy,
      clipper: ChatBubbleClipper3(
          type: BubbleType.receiverBubble, nipSize: 5, radius: 15),
      child: child,
    );
  }
}

class MessageBody extends StatefulWidget {
  const MessageBody({super.key, required this.message});

  final TherapyChatMessage message;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextView(
            text: widget.message.message.toString().trim(),
            lineHeight: 1.5,
            color: Pallets.white,
            fontSize: 15.sp,
            wordSpacing: 1,
            fontWeight: FontWeight.w500),
        8.verticalSpace,
      ],
    );
  }
}
