import 'package:flutter/material.dart';
import 'package:raycon_app/features/support/presentaion/widgets/receiver_message_item.dart';
import 'package:raycon_app/features/support/presentaion/widgets/sender_message_item.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final dynamic message;
  final bool isSender;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints:  BoxConstraints(maxWidth: AppUtils.getDeviceSize(context).width*0.5 ),
        alignment: widget.isSender
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: widget.isSender
            ? SenderMessageItem(
                message: widget.message,
              )
            : ReceiverMessageItem(
                message: widget.message,
              ));
  }

// bool get isSender => true;
}
