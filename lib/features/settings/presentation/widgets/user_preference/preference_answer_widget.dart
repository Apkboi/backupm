import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/options_widget.dart';

class PreferenceAnswerBox extends StatefulWidget {
  const PreferenceAnswerBox({
    Key? key,
    required this.question,
  }) : super(key: key);
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
                        horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Pallets.userChatBg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.question.answer ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        8.verticalSpace,
                        Text("3:00PM ",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    )),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        : (widget.question.options.isNotEmpty &&
                context.read<UserPreferenceCubit>().currentQuestion?.id ==
                    widget.question.id)
            ? OptionsWidget(question: widget.question)
            : 0.horizontalSpace;
  }
}
