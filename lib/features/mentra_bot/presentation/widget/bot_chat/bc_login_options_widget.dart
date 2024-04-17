import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/local_auth/presentation/blocs/local_auth/local_auth_cubit.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';

class BcLoginOptionsWidget extends StatefulWidget {
  const BcLoginOptionsWidget({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BcLoginOptionsWidget> createState() => _BcLoginOptionsWidgetState();
}

class _BcLoginOptionsWidgetState extends State<BcLoginOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: injector.get(),
      listener: _listenToLoginBloc,
      builder: (context, state) {
        return Column(
          children: [
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomNeumorphicButton(
                  onTap: () {
                    context.read<BotChatCubit>().answerQuestion(
                        id: widget.message.id,
                        answer: "Continue with Email",
                        // nextFlow: BotChatFlow.signup,
                        nextLoginStage: LoginStage.EMAILPREVIEW);
                    // context.pushNamed(PageUrl.loginPreview);
                  },
                  padding: const EdgeInsets.all(15),
                  expanded: false,
                  // fgColor: Pallets.black,
                  color: Pallets.primary,
                  text: "Continue with Email",
                ),
              ],
            ),
            if (Platform.isIOS)
              Column(
                children: [
                  16.verticalSpace,
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
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          )
                        ],
                      ),
                      onPressed: () {
                        injector.get<LoginBloc>().add(const AppleAuthEvent());
                      },
                    ),
                  ),
                ],
              ),
            16.verticalSpace,
            // if (Platform.isAndroid)
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
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    )
                  ],
                ),
                onPressed: () {
                  // injector.get<regbloc.RegistrationBloc>().add(const regbloc.SignupCompleteEvent());

                  injector.get<LoginBloc>().add(const GoogleAuthEvent());
                },
              ),
            ),
            16.verticalSpace,
            // if (SessionManager.instance.bioMetricEnabled &&
            //     injector.get<UserBloc>().appUser != null)
            //   Align(
            //     alignment: Alignment.centerRight,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         CustomNeumorphicButton(
            //           onTap: () {
            //             _authenticateWithBioMetric();
            //             // context.pushNamed(PageUrl.loginPreview);
            //           },
            //           expanded: false,
            //           // fgColor: Pallets.black,
            //           color: Pallets.secondary,
            //           fgColor: Pallets.black,
            //           padding: const EdgeInsets.all(15),
            //           text: "Continue with Biometric",
            //         ),
            //       ],
            //     ),
            //   ),
            150.verticalSpace
          ],
        );
      },
    );
  }

  void _listenToLoginBloc(BuildContext context, LoginState state) {
    if (state is OauthLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is LoginOauthSuccessState) {
      context.pop();
      if (state.response.data.newUser) {
        CustomDialogs.error('Account not found, Please sign up.');
      } else {
        context.read<BotChatCubit>().answerQuestion(
            id: widget.message.id,
            answer: "Continue with Google",
            nextFlow: BotChatFlow.talkToMentra);
      }
    }
    if (state is OauthFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is LoginLoadingState) {
      CustomDialogs.showLoading(context);
    }

    if (state is LoginFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
      // _pinController.resetPin();
    }
  }

  void _authenticateWithBioMetric() async {
    var bioMetricAuthenticated =
        await injector.get<LocalAuthCubit>().authenticateUser();

    if (bioMetricAuthenticated) {
      var passcode = await SessionManager.instance.userPassKeyGet;
      if (passcode != null) {
        injector.get<LoginBloc>().add(LoginUserEvent(
            email: injector.get<UserBloc>().appUser!.email,
            password: passcode));
      } else {
        context.goNamed(PageUrl.welcomeScreen);
      }
    }
  }
}
