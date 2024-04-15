import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/gen/assets.gen.dart';

import '../../../../../common/widgets/text_view.dart';

class PreferenceQuestionBox extends StatefulWidget {
  const PreferenceQuestionBox({
    Key? key,
    required this.question,
  }) : super(key: key);

  final QuestionPromptModel question;

  @override
  State<PreferenceQuestionBox> createState() => _PreferenceQuestionBoxState();
}

class _PreferenceQuestionBoxState extends State<PreferenceQuestionBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, right: 0),
              child: ImageWidget(
                imageUrl: Assets.images.pngs.launcherIcon.path,
                fit: BoxFit.cover,
                size: 40,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.question.question.length,
                (index) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2 + 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: widget.question.question.reversed.toList()[index],
                        lineHeight: 1.5,
                        style: const TextStyle(color: Pallets.white),
                      ),
                      8.verticalSpace,
                      TextView(
                          text: TimeUtil.formatTime(
                              widget.question.questionTime!),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Pallets.white,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
