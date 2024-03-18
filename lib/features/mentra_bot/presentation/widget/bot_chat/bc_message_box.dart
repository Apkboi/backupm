import 'package:flutter/material.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_answer_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_mentra_message_widget.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_user_message_widget.dart';

class BCMessageBox extends StatefulWidget {
  const BCMessageBox({
    Key? key,
    required this.message,
  }) : super(key: key);

  final BotChatmessageModel message;

  @override
  State<BCMessageBox> createState() => _BCMessageBoxState();
}

class _BCMessageBoxState extends State<BCMessageBox> {
  @override
  Widget build(BuildContext context) {
    return widget.message.isFromBot
        ? Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: BCMentraMessageWidget(
                    message: [widget.message.message],
                    isTyping: widget.message.isTyping ?? false,
                    child: widget.message.child,
                  )),
              Container(
                  alignment: Alignment.centerRight,
                  child: BCMessageAnswerWidget(
                    messsage: widget.message,
                  ))
            ],
          )
        : BCUserMessageWidget(message: [widget.message.message]);
  }

// bool get isSender => true;
}
