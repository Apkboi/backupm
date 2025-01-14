import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/options_color_scheme.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key, required this.question});

  final TherapyPreferenceMessageModel question;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: question.options.length,
        itemBuilder: (context, index) {
          bool isSelected = question.answer == question.options[index];

          return HapticInkWell(
            onTap: () {
              context.read<UserPreferenceCubit>().answerQuestion(
                  id: question.id, answer: question.options[index]);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      // width: 100,
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // shape: BoxShape.circle,
                        color: isSelected
                            ? Pallets.lightSecondary
                            : OptionsColorScheme.fromIndex(index).bgColor,
                      ),
                      child: Center(
                        child: Text(
                          question.options[index],
                          style: TextStyle(
                              color:
                                  OptionsColorScheme.fromIndex(index).textColor,
                              fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
