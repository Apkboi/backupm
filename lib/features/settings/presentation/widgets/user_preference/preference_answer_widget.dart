import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/settings/data/data_sources/preference_questions.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/options_widget.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class PreferenceAnswerBox extends StatefulWidget {
  const PreferenceAnswerBox({
    super.key,
    required this.question,
  });

  final QuestionPromptModel question;

  @override
  State<PreferenceAnswerBox> createState() => _PreferenceAnswerBoxState();
}

class _PreferenceAnswerBoxState extends State<PreferenceAnswerBox> {
  @override
  Widget build(BuildContext context) {
    return (widget.question.answer != null &&
            context.read<UserPreferenceCubit>().currentQuestion?.id !=
                widget.question.id)
        ? HapticInkWell(
            onTap: () {
              context
                  .read<UserPreferenceCubit>()
                  .updateCurrentQuestion(widget.question);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 0.7.sw),
                  child: ChatBubble(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 7),
                    backGroundColor: Pallets.secondary,
                    clipper: ChatBubbleClipper3(
                        type: BubbleType.sendBubble, nipSize: 4, radius: 15),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextView(
                            text: widget.question.answer ?? '',
                            fontSize: 15.sp,
                            color: Pallets.black,
                            lineHeight: 1.5,
                            fontWeight: FontWeight.w500),
                        // 8.verticalSpace,
                        // Text(TimeUtil.formatTime(widget.question.answerTime!),
                        //     style: TextStyle(
                        //       fontSize: 11.sp,
                        //       fontWeight: FontWeight.w600,
                        //     ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                      TimeUtil.formatTime(
                          widget.question.answerTime ?? DateTime.now()),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Pallets.black,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
          )
        : (widget.question.options.isNotEmpty &&
                context.read<UserPreferenceCubit>().currentQuestion?.id ==
                    widget.question.id)
            ? OptionsWidget(question: widget.question)
            : widget.question.id !=
                    PreferenceQuestionsDataSource().therapyQuestions.last.id
                ? 0.verticalSpace
                : 0.horizontalSpace;
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// constraints: BoxConstraints(
// maxWidth:
// MediaQuery.of(context).size.width / 2 + 40),
// padding: const EdgeInsets.symmetric(
// horizontal: 10, vertical: 16),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// color: Pallets.white),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// const Text(
// 'Type in answer..',
// style: TextStyle(
// fontSize: 14,
// ),
// ),
// 8.verticalSpace,
// ],
// )),
// const SizedBox(
// height: 5,
// ),
// ],
// )
