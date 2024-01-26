import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key, required this.question});

  final QuestionPromptModel question;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: question.options.length,
        itemBuilder: (context, index) {
          bool isSelected = question.answer == question.options[index];

          return InkWell(
            onTap: () {
              // TODO UPDATE QUESTION ANSWER

              context.read<UserPreferenceCubit>().answerQuestion(
                  id: question.id, answer: question.options[index]);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    // shape: BoxShape.circle,
                    color: isSelected
                        ? Pallets.lightSecondary
                        : Pallets.lightTurquoise,
                  ),
                  child: Center(
                    child: Text(
                      question.options[index],
                      style: TextStyle(color: Pallets.black, fontSize: 16.sp),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
