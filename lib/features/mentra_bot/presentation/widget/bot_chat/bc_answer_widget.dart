import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_login_options_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_user_message_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_welcome_option.dart';

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
      AnswerType.LOGIN_OPTION => BcLoginOptionsWidget(message: widget.messsage,),
      AnswerType.WELCOME_OPTIONS => const BCWelcomeOption(),
      AnswerType.SIGNUP_OPTION => 0.horizontalSpace,
      AnswerType.TEXT => 0.horizontalSpace,
      AnswerType.NUMBER => 0.horizontalSpace,
      AnswerType.AVATAR => 0.horizontalSpace,
      AnswerType.ACTION_OPTION => const Text('Login Option'),
      AnswerType.NONE => 0.horizontalSpace,
    };
  }
}
