import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class SignupOptionScreen extends StatefulWidget {
  const SignupOptionScreen({super.key});

  @override
  State<SignupOptionScreen> createState() => _SignupOptionScreenState();
}

class _SignupOptionScreenState extends State<SignupOptionScreen> {
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
                            QuestionBox(message: [
                              'Awesome choice, ${injector.get<RegistrationBloc>().registrationPayload.name} 🎉 Would you like to sign up using your email, Google, or Apple?',
                            ], isSender: false),
                            if(Platform.isIOS)
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomButton(
                                foregroundColor: Pallets.black,
                                bgColor: Pallets.white,
                                isExpanded: false,
                                elevation: 0,
                                padding: const EdgeInsets.all(16),
                                borderRadius: BorderRadius.circular(100),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ImageWidget(
                                      imageUrl: Assets.images.svgs.apple,
                                      size: 15,
                                    ),
                                    5.horizontalSpace,
                                    TextView(
                                      text: 'Continue with Apple',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  injector
                                      .get<RegistrationBloc>()
                                      .add(const AppleAuthEvent());
                                },
                              ),
                            ),
                            16.verticalSpace,

                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomButton(
                                foregroundColor: Pallets.black,
                                bgColor: Pallets.white,
                                elevation: 0,
                                isExpanded: false,
                                padding: const EdgeInsets.all(16),
                                borderRadius: BorderRadius.circular(100),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ImageWidget(
                                      imageUrl: Assets.images.svgs.google,
                                      size: 15,
                                    ),
                                    5.horizontalSpace,
                                    TextView(
                                      text: 'Continue with Google',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  injector
                                      .get<RegistrationBloc>()
                                      .add(const GoogleAuthEvent());
                                },
                              ),
                            ),
                            16.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomNeumorphicButton(
                                  onTap: () {
                                    context.pushNamed(PageUrl.userEmailScreen);
                                  },
                                  expanded: false,
                                  color: Pallets.primary,
                                  text: "Sign up with Email",
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
                      //     // onSaved: widget.onSaved,
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
