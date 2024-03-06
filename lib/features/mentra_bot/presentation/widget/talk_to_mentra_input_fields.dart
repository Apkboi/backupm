import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';

class TalkToMentraInputFields extends StatefulWidget {
  const TalkToMentraInputFields({super.key, required this.message});

  final BotChatModel message;

  @override
  State<TalkToMentraInputFields> createState() =>
      _TalkToMentraInputFieldsState();
}

class _TalkToMentraInputFieldsState extends State<TalkToMentraInputFields> {
  @override
  Widget build(BuildContext context) {
    switch (widget.message.answerType) {
      case AnswerType.LOGIN_OPTION:
      // TODO: Handle this case.
      case AnswerType.WELCOME_OPTIONS:
      // TODO: Handle this case.
      case AnswerType.SIGNUP_OPTION:
      // TODO: Handle this case.
      case AnswerType.TEXT:
        return _InputBar(
          onAnswer: (answer) {},
        );
      case AnswerType.NUMBER:
      // TODO: Handle this case.
      case AnswerType.AVATAR:
      // TODO: Handle this case.
      case AnswerType.ACTION_OPTION:
      // TODO: Handle this case.
      case AnswerType.NONE:
        return 0.horizontalSpace;
      default:
        return 0.horizontalSpace;
    }
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({Key? key, required this.onAnswer}) : super(key: key);
  final Function(String answer) onAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FilledTextField(
                hasBorder: false,
                hasElevation: false,
                suffix: InkWell(
                  onTap: () async {},
                  child: const Icon(
                    Icons.send_rounded,
                    size: 25,
                  ),
                ),
                fillColor: Pallets.white,
                contentPadding: const EdgeInsets.all(16),
                radius: 45,
                hint: 'Enter response'))
      ],
    );
  }
}
