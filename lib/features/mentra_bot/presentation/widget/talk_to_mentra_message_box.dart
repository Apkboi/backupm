import 'package:flutter/material.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/mentra_message_item.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/user_message_item.dart';

class TalkToMentraMessageBox extends StatefulWidget {
  const TalkToMentraMessageBox({
    Key? key,
    required this.message,
    this.child,
  }) : super(key: key);

  final MentraChatModel message;
  final Widget? child;

  @override
  State<TalkToMentraMessageBox> createState() => _TalkToMentraMessageBoxState();
}

class _TalkToMentraMessageBoxState extends State<TalkToMentraMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints:  BoxConstraints(maxWidth: AppUtils.getDeviceSize(context).width*0.5 ),
        alignment: widget.message.isMentraMessage
            ? Alignment.centerLeft
            : Alignment.centerRight,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        child: !widget.message.isMentraMessage
            ? UserMessageItem(
                message: widget.message,
                time: widget.message.time!,
                child: widget.child,
              )
            : MentraMessageItem(
                message: [widget.message.content],
                time: widget.message.time!,
                isTyping: widget.message.isTyping,
                child: widget.child,
              ));
  }

// bool get isSender => true;
}
