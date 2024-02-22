import 'package:flutter/material.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/mentra_message_item.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/user_message_item.dart';
import 'package:mentra/features/therapy/data/models/chat_message.dart';

class TherapyMessageBox extends StatefulWidget {
  const TherapyMessageBox({
    Key? key,
    required this.message,
    required this.isSender,
    this.child,
  }) : super(key: key);

  final TherapyChatMessage message;
  final Widget? child;
  final bool isSender;

  @override
  State<TherapyMessageBox> createState() => _TherapyMessageBoxState();
}

class _TherapyMessageBoxState extends State<TherapyMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints:  BoxConstraints(maxWidth: AppUtils.getDeviceSize(context).width*0.5 ),
        alignment:
           !widget.message.isTherapist ? Alignment.centerRight : Alignment.centerLeft,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        child: !widget.message.isTherapist
            ? UserMessageItem(
                message: [widget.message.message],
                child: widget.child,
              )
            : MentraMessageItem(
                message: [widget.message.message],
                child: widget.child,
              ));
  }

// bool get isSender => true;
}
