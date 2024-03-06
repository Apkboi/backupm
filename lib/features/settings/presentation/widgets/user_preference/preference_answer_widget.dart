import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/data/data_sources/preference_questions.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/options_widget.dart';

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
    return (widget.question.answer != null && context.read<UserPreferenceCubit>().currentQuestion?.id != widget.question.id)
        ? InkWell(
            onTap: () {
              context
                  .read<UserPreferenceCubit>()
                  .updateCurrentQuestion(widget.question);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2 + 40),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Pallets.userChatBg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.question.answer ?? '',
                          // textAlign:TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Pallets.black,
                              fontWeight: FontWeight.w500),
                        ),
                        // 8.verticalSpace,
                        // Text(TimeUtil.formatTime(widget.question.answerTime!),
                        //     style: TextStyle(
                        //       fontSize: 11.sp,
                        //       fontWeight: FontWeight.w600,
                        //     ))
                      ],
                    )),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        : (widget.question.options.isNotEmpty && context.read<UserPreferenceCubit>().currentQuestion?.id == widget.question.id)
            ? OptionsWidget(question: widget.question)
            : widget.question.id != PreferenceQuestionsDataSource().therapyQuestions.last.id
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width / 2 + 40),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Pallets.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Type in answer..',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              8.verticalSpace,
                            ],
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                : 0.horizontalSpace;
  }
}
