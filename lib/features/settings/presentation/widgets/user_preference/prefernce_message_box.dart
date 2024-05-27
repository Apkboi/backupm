import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_typing_widget.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/gen/assets.gen.dart';

import '../../../../../common/widgets/text_view.dart';

class PreferenceQuestionBox extends StatefulWidget {
  const PreferenceQuestionBox({
    Key? key,
    required this.question,
  }) : super(key: key);

  final TherapyPreferenceMessageModel question;

  @override
  State<PreferenceQuestionBox> createState() => _PreferenceQuestionBoxState();
}

class _PreferenceQuestionBoxState extends State<PreferenceQuestionBox> {
  @override
  Widget build(BuildContext context) {
    // context.p
    return Builder(builder: (context) {
      if (widget.question.isTyping) {
        return const BotTypingWidget();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 13.r,
                  child: ImageWidget(
                    imageUrl: Assets.images.pngs.launcherIcon.path,
                    fit: BoxFit.cover,
                    width: 45.w,
                    height: 40.h,

                    // size: 40,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 0.75.sw,
                ),
                //
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    ... List.generate(
                      widget.question.question.length,
                          (index) => Padding(
                        padding: EdgeInsets.only(
                            bottom: index == widget.question.question.length - 1
                                ? 0
                                : 5.0),
                        child: messageIsLast(index)
                            ? _RoundedBackground(
                            question: widget.question.question.reversed
                                .toList()[index])
                            : ChatBubble(
                          padding: const EdgeInsets.only(
                              right: 8, bottom: 8, left: 15, top: 5),
                          backGroundColor: Pallets.navy,
                          clipper: ChatBubbleClipper3(
                              type: BubbleType.receiverBubble,
                              nipSize: 5,
                              radius: 15),
                          child: _MessageContent(
                              question: widget.question.question.reversed
                                  .toList()[index]),
                        ),
                      ),
                    ),
                    Text(TimeUtil.formatTime(widget.question.questionTime!.toLocal()),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Pallets.navy,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  bool messageIsLast(int index) =>
      index == 0 && widget.question.question.length > 1;
}

class _MessageContent extends StatefulWidget {
  const _MessageContent({super.key, required this.question});

  final String question;

  @override
  State<_MessageContent> createState() => _MessageContentState();
}

class _MessageContentState extends State<_MessageContent> {
  @override
  Widget build(BuildContext context) {
    return TextView(
        text: widget.question,
        lineHeight: 1.5,
        color: Pallets.white,
        fontSize: 15,
        wordSpacing: 1,
        fontWeight: FontWeight.w500);
  }
}

class _RoundedBackground extends StatelessWidget {
  const _RoundedBackground({super.key, required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      constraints: BoxConstraints(maxWidth: 0.75.sw),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.only(
          //     bottomLeft: index.isEven
          //         ? Radius.zero
          //         : const Radius.circular(15),
          //     topRight: const Radius.circular(15),
          //     bottomRight: const Radius.circular(15),
          //     topLeft: !index.isEven
          //         ? Radius.zero
          //         : const Radius.circular(15)
          // ),
          color: Pallets.navy),
      child: _MessageContent(question: question),
    );
  }
}
