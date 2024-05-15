import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';
import 'package:mentra/features/therapy/presentation/widgets/chat/therapist_message_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/chat/user_message_item.dart';

class TherapyMessageBox extends StatefulWidget {
  const TherapyMessageBox({
    Key? key,
    required this.message,
    required this.showSenderImage,
  }) : super(key: key);

  final TherapyChatMessage message;
  final bool showSenderImage;

  @override
  State<TherapyMessageBox> createState() => _TherapyMessageBoxState();
}

class _TherapyMessageBoxState extends State<TherapyMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 1.sw * 0.5),
        alignment: !widget.message.isTherapist
            ? Alignment.centerRight
            : Alignment.centerLeft,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        child: !widget.message.isTherapist
            ? TherapyChatUserMessageItem(
                message: widget.message,
              )
            : TherapistMessageItem(
                message: widget.message,
                showImage: widget.showSenderImage,
              ));
  }

// bool get isSender => true;
}
