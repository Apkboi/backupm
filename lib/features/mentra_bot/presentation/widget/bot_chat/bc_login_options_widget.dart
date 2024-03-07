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
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart'
    as regbloc;
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';
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
                        answer: "Continue with email",
                        // nextFlow: BotChatFlow.signup,
                        nextLoginStage: LoginStage.EMAILPREVIEW);
                    // context.pushNamed(PageUrl.loginPreview);
                  },
                  expanded: false,
                  // fgColor: Pallets.black,
                  color: Pallets.primary,
                  text: "Continue with email",
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
                  injector.get<LoginBloc>().add(const GoogleAuthEvent());
                },
              ),
            ),
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
    if (state is OauthSuccessState) {
      context.pop();
      if (state.response.data.newUser) {
        injector
            .get<regbloc.RegistrationBloc>()
            .updateFields(email: state.response.data.email);
        context.read<BotChatCubit>().answerQuestion(
            id: widget.message.id,
            answer: "Continue with Google",
            nextFlow: BotChatFlow.signup,
            nextSignupStage: SignupStage.YEAR);
        // context.pop();
        // context.pushNamed(PageUrl.selectYearScreen);
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
