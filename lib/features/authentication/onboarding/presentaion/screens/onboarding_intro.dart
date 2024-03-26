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
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        controller.animateTo(controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
    );

    super.initState();
  }

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
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller,
                          child: Column(
                            children: [
                              50.verticalSpace,

                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const QuestionBox(message: [
                                    '🎉 Welcome! It\'s wonderful to have you on board. I’m Mentra, your 24/7 emotional and mental well-being buddy, tailored just for you',
                                    'Your privacy is a big deal for me. Every chat here is private and anonymous, meaning you can truly be yourself without any worries.\nYour data? It’s yours and yours alone – safe, secure, and respected.',
                                  ], isSender: false),
                                  const QuestionBox(message: [
                                    'Before we proceed, do you already have a Mentra account, or would you like to create a new one ?',
                                  ], isSender: false),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomNeumorphicButton(
                                        onTap: () {
                                          context.pushNamed(
                                              PageUrl.newLoginScreen);
                                        },
                                        expanded: false,
                                        fgColor: Pallets.black,
                                        color: Pallets.secondary,
                                        text: "I already have an account.",
                                      ),
                                    ],
                                  ),
                                  15.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomNeumorphicButton(
                                        onTap: () {
                                          injector
                                              .get<RegistrationBloc>()
                                              .updateFields(role: 'User');
                                          context.pushNamed(
                                              PageUrl.usernameScreen);
                                        },
                                        expanded: false,
                                        color: Pallets.primary,
                                        text:
                                            "I'd like to create a new account",
                                      ),
                                    ],
                                  ),
                                  50.verticalSpace
                                ],
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
                      ),
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
