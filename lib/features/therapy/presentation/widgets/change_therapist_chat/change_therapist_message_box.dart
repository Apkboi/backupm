import 'package:flutter/material.dart';
import 'package:mentra/features/therapy/data/models/change_therapist_message_model.dart';
import 'package:mentra/features/therapy/presentation/widgets/change_therapist_chat/mentras_message_box.dart';
import 'package:mentra/features/therapy/presentation/widgets/change_therapist_chat/retry_button.dart';
import 'package:mentra/features/therapy/presentation/widgets/change_therapist_chat/user_message_box.dart';
import 'package:mentra/features/therapy/presentation/widgets/change_therapist_chat/view_profile_button.dart';

class ChangeTherapistMessageBox extends StatefulWidget {
  const ChangeTherapistMessageBox({
    super.key,
    required this.message,
    this.child,
  });

  final ChangeTherapistMessageModel message;
  final Widget? child;

  @override
  State<ChangeTherapistMessageBox> createState() =>
      _ChangeTherapistMessageBoxState();
}

class _ChangeTherapistMessageBoxState extends State<ChangeTherapistMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints:  BoxConstraints(maxWidth: AppUtils.getDeviceSize(context).width*0.5 ),
        alignment: widget.message.isSender
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Builder(
          builder: (context) {
            return switch (widget.message.messageType) {
              // TODO: Handle this case.
              ChangeTherapistMessageType.processing => MentrasMessageBox(
                  message: widget.message,
                ),
              // TODO: Handle this case.
              ChangeTherapistMessageType.reply => widget.message.isSender
                  ? UserMessageBox(
                      message: widget.message,
                    )
                  : MentrasMessageBox(
                      message: widget.message,
                    ),
              // TODO: Handle this case.
              ChangeTherapistMessageType.retry => const RetryButton(),
              // TODO: Handle this case.
              ChangeTherapistMessageType.therapistSuggestion =>
                ViewProfileButton(therapist: widget.message.therapist!),
            };
          },
        ));
  }

// bool get isSender => true;
}

// widget.message.isSender
//             ? UserMessageItem(
//                 message: widget.message,
//                 child: widget.child,
//               )
//             : MentraMessageItem(
//                 message: widget.message,
//                 child: widget.child,
//               )
