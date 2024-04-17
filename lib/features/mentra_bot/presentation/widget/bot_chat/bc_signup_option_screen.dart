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
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';

class BCSignupOptionsField extends StatelessWidget {
  const BCSignupOptionsField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      bloc: injector.get(),
      listener: _listenToRegistrationBloc,
      builder: (context, state) {
        return Column(
          children: [
            if (Platform.isIOS)
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
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    )
                  ],
                ),
                onPressed: () {
                  injector.get<RegistrationBloc>().add(const GoogleAuthEvent());
                },
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomNeumorphicButton(
                  onTap: () {

                    context.read<BotChatCubit>().answerQuestion(
                        id: message.id,
                        answer: "Sign up with Email",
                        nextSignupStage: SignupStage.EMAIL);

                    // context.pushNamed(PageUrl.userEmailScreen);
                  },
                  expanded: false,
                  color: Pallets.primary,
                  text: "Sign up with Email",
                ),
              ],
            ),
          ],
        );
      },
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

        context.read<BotChatCubit>().answerQuestion(
            id: message.id,
            answer: state.response.data.email.toString(),
            nextSignupStage: SignupStage.YEAR);

        // context.pushNamed(PageUrl.selectYearScreen);
      } else {

        context.read<BotChatCubit>().answerQuestion(
            id: message.id,
            answer: "Continue with Google",
            nextFlow: BotChatFlow.talkToMentra);

        // context.read<BotChatCubit>().answerQuestion(
        //     id: message.id,
        //     answer: state.response.data.email.toString(),
        //     nextFlow: BotChatFlow.talkToMentra,
        //     nextSignupStage: SignupStage.YEAR);
        // context.pop();
        // context.pushNamed(PageUrl.talkToMentraScreen);
      }
    }
    if (state is OauthFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
