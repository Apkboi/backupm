import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';

class BCWelcomeOption extends StatelessWidget {
  const BCWelcomeOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomNeumorphicButton(
              onTap: () {
                context.read<BotChatCubit>().answerQuestion(
                    id: 2,
                    answer: "I already have an account.",
                    nextFlow: BotChatFlow.login,
                    nextLoginStage: LoginStage.INITIAL);
                // context.pushNamed(PageUrl.newLoginScreen);
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
                injector.get<RegistrationBloc>().updateFields(role: 'User');
                // context.pushNamed(PageUrl.usernameScreen);

                context.read<BotChatCubit>().answerQuestion(
                    id: 2,
                    answer: "I'd like to create a new account",
                    nextFlow: BotChatFlow.signup,
                    nextSignupStage: SignupStage.USERNAME);
              },
              expanded: false,
              color: Pallets.primary,
              text: "I'd like to create a new account",
            ),
          ],
        ),
      ],
    );
  }
}
