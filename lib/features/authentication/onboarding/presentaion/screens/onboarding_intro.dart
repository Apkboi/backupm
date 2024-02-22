import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';

class OnboardingIntro extends StatefulWidget {
  const OnboardingIntro({super.key});

  @override
  State<OnboardingIntro> createState() => _OnboardingIntroState();
}

class _OnboardingIntroState extends State<OnboardingIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AppBg(),
          BlocConsumer<RegistrationBloc, RegistrationState>(
            bloc: injector.get(),
            listener: _listenToRegistrationBloc,
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.topLeft,
                          child: CustomBackButton()),
                      16.verticalSpace,

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const QuestionBox(message: [
                              'Hi, am mentra,',
                              'How will you like to proceed',
                            ], isSender: false),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomNeumorphicButton(
                                  onTap: () {

                                    injector.get<RegistrationBloc>().updateFields(role: 'User');
                                    context.pushNamed(PageUrl.usernameScreen);
                                  },
                                  expanded: false,
                                  color: Pallets.primary,
                                  text: "Create an account",
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomNeumorphicButton(
                                  onTap: () {
                                    context.pushNamed(PageUrl.newLoginScreen);
                                  },
                                  expanded: false,
                                  fgColor: Pallets.black,
                                  color: Pallets.secondary,
                                  text: "Access my account",
                                ),
                              ],
                            ),
                            150.verticalSpace
                          ],
                        ),
                      )

                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       bottom: MediaQuery.of(context).viewInsets.bottom),
                      //   child: const FilledTextField(
                      //     hint: "Type here..",
                      //     hasElevation: false,
                      //     outline: false,
                      //     hasBorder: false,
                      //     suffix: Icon(
                      //       Icons.send_rounded,
                      //       size: 25,
                      //     ),
                      //     // onChanged: widget.onChanged,
                      //     // onFieldSubmitted: widget.onFieldSubmitted,
                      //     // onSaved: widget.oxSaved,
                      //     radius: 43,
                      //     // preffix: const Icon(Iconsax.search_normal4),
                      //     contentPadding:
                      //         EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      //     fillColor: Pallets.white,
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _listenToRegistrationBloc(
      BuildContext context, RegistrationState state) {
    if (state is OauthLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is OauthSuccessState) {
      if (state.response.data.newUser) {
        injector
            .get<RegistrationBloc>()
            .updateFields(email: state.response.data.email);
        context.pop();
        context.pushNamed(PageUrl.selectYearScreen);
      } else {
        context.pop();
        context.pushNamed(PageUrl.welcomeScreen);
      }
    }
    if (state is OauthFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
