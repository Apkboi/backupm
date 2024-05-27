import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/options_color_scheme.dart';
import 'package:mentra/features/settings/data/models/change_therapist_stage.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/widgets/change_therapist_chat/retry_button.dart';
import 'package:uuid/uuid.dart';

class ChangeTherapistOptionsWidget extends StatelessWidget {
  const ChangeTherapistOptionsWidget({super.key, required this.question});

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
            onTap: () async {
              if (question.changeTherapistStage ==
                  ChangeTherapistStage.foundTherapist) {
                final bool? matched = await context
                    .pushNamed(PageUrl.acceptTherapistScreen, queryParameters: {
                  PathParam.therapist:
                      jsonEncode(question.suggestedTherapist?.toJson())
                });

                logger.w(matched);
                if (matched != null) {
                  context
                      .read<UserPreferenceCubit>()
                      .stagedMessages
                      .last
                      .answer = question.options[index];
                  // context.read<UserPreferenceCubit>().answerChangeTherapistQuestion(
                  //     id: question.id.toString(), answer: question.options[index]);
                  if (matched) {
                    context.read<UserPreferenceCubit>().stagedMessages.add(
                        TherapyPreferenceMessageModel(
                            therapyMessageType:
                                TherapyMessageType.changeTherapistMessage,
                            question: [
                              'Congratulations! You are now connected with ${question.suggestedTherapist?.user.name}. Good luck with your therapy sessions!'
                            ],
                            options: [],
                            key: '0',
                            id: Uuid().v4()));
                  } else {
                    context.read<UserPreferenceCubit>().searchForTherapist();
                    // context.read<TherapyBloc>().add(
                    //     const MatchTherapistEvent(updatedPreference: false));
                  }
                }
              } else {
                context
                    .read<UserPreferenceCubit>()
                    .answerChangeTherapistQuestion(
                        id: question.id, answer: question.options[index]);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 8.0.h),
                    child: Container(
                      // width: 100,
                      height: 45.h,
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
