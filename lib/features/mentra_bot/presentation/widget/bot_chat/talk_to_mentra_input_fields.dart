import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';

class TalkToMentraInputFields extends StatefulWidget {
  const TalkToMentraInputFields({super.key, required this.currentMessage});

  final BotChatmessageModel currentMessage;

  @override
  State<TalkToMentraInputFields> createState() =>
      _TalkToMentraInputFieldsState();
}

class _TalkToMentraInputFieldsState extends State<TalkToMentraInputFields> {
  @override
  Widget build(BuildContext context) {
    switch (widget.currentMessage.answerType) {
      case AnswerType.LOGIN_OPTION:
        return 0.horizontalSpace;
      case AnswerType.WELCOME_OPTIONS:
        return 0.horizontalSpace;
      case AnswerType.SIGNUP_OPTION:
        return 0.horizontalSpace;
      case AnswerType.TEXT:
        return InputBar(
          onAnswer: (answer) {},
        );
      case AnswerType.NUMBER:
        return InputBar(
          onAnswer: (answer) {},
          inputType: TextInputType.number,
        );
      case AnswerType.AVATAR:
        return 0.horizontalSpace;

      case AnswerType.ACTION_OPTION:
        return 0.horizontalSpace;

      case AnswerType.NONE:
        return 0.horizontalSpace;
      default:
        return 0.horizontalSpace;
    }
  }
}
