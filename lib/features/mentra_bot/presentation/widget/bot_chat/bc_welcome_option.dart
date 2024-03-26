import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class BCWelcomeOption extends StatefulWidget {
  const BCWelcomeOption({super.key});

  @override
  State<BCWelcomeOption> createState() => _BCWelcomeOptionState();
}

class _BCWelcomeOptionState extends State<BCWelcomeOption> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomNeumorphicButton(
                onTap: () {
                  context.read<BotChatCubit>().answerQuestion(
                      id: 2,
                      answer: "I already have an account",
                      nextFlow: BotChatFlow.login,
                      nextLoginStage: LoginStage.INITIAL);
                  // context.pushNamed(PageUrl.newLoginScreen);
                },
                expanded: false,
                fgColor: Pallets.black,
                color: Pallets.secondary,
                text: "I already have an account",
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
      ),
    );
  }
}
