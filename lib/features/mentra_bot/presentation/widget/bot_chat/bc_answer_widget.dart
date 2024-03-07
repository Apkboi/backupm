import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/BCTextInputField.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_avatar_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_confirm_passcode_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_email_verification.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_login_options_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_select_year_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_set_passcode_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_user_message_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_welcome_option.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/user_email_field.dart';

class BCMessageAnswerWidget extends StatefulWidget {
  const BCMessageAnswerWidget({super.key, required this.messsage});

  final BotChatmessageModel messsage;

  @override
  State<BCMessageAnswerWidget> createState() => _BCMessageAnswerWidgetState();
}

class _BCMessageAnswerWidgetState extends State<BCMessageAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.messsage.answer != null) {
      return BCUserMessageWidget(message: [widget.messsage.answer]);
    }
    return switch (widget.messsage.answerType) {
      AnswerType.LOGIN_OPTION => BcLoginOptionsWidget(
          message: widget.messsage,
        ),
      AnswerType.WELCOME_OPTIONS => const BCWelcomeOption(),
      AnswerType.SIGNUP_OPTION => 0.horizontalSpace,
      AnswerType.CHAT => 0.verticalSpace,
      AnswerType.NUMBER => 0.horizontalSpace,
      AnswerType.AVATAR => 0.verticalSpace,
      AnswerType.ACTION_OPTION => const Text('Login Option'),
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
    };
  }
}