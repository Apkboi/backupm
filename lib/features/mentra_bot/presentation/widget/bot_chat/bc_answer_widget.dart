import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_login_options_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_permissions_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_signup_option_screen.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_user_message_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_welcome_option.dart';

class BCMessageAnswerWidget extends StatefulWidget {
  const BCMessageAnswerWidget({super.key, required this.messsage});

  final BotChatmessageModel messsage;

  @override
  State<BCMessageAnswerWidget> createState() => _BCMessageAnswerWidgetState();
}

class _BCMessageAnswerWidgetState extends State<BCMessageAnswerWidget>
    with SingleTickerProviderStateMixin {
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

    Future.delayed(const Duration(milliseconds: 300), () {
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
      child: Builder(
        builder: (context) {
          if (widget.messsage.answer != null) {
            return BCUserMessageWidget(
              message: [widget.messsage.answer],
              child: widget.messsage.answerWidget,
            );
          }
          return switch (widget.messsage.answerType) {
            AnswerType.LOGIN_OPTION => BcLoginOptionsWidget(
                message: widget.messsage,
              ),
            AnswerType.WELCOME_OPTIONS => const BCWelcomeOption(),
            AnswerType.SIGNUP_OPTION =>
              BCSignupOptionsField(message: widget.messsage),
            AnswerType.CHAT => 0.verticalSpace,
            AnswerType.NUMBER => 0.horizontalSpace,
            AnswerType.AVATAR => 0.verticalSpace,
            AnswerType.BIOMETRIC_OPTIONS =>
              BCPermissionsField(message: widget.messsage),
            AnswerType.NONE => 0.horizontalSpace,
            AnswerType.EMAIL => 0.verticalSpace,
            AnswerType.EMAIL_VERIFICATION => 0.verticalSpace,
            AnswerType.SET_PASSCODE => 0.verticalSpace,
            AnswerType.SELECTYEAR => 0.verticalSpace,
            AnswerType.CONFIRMPASSCODE => 0.verticalSpace,
            // TODO: Handle this case.
            AnswerType.USERNAME => 0.verticalSpace,
            // TODO: Handle this case.
            AnswerType.EMAIL_PREVIW => 0.verticalSpace,
            // TODO: Handle this case.
            AnswerType.LOGIN_PASSCODE => 0.verticalSpace,
            // TODO: Handle this case.
            AnswerType.NOTIFICATION_OPTIONS =>
              BCPermissionsField(message: widget.messsage),
          };
        },
      ),
    );
  }
}
