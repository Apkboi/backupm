import 'package:flutter/material.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/change_therapist_answer_widget.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/prefernce_message_box.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/preference_answer_widget.dart';
import 'package:mentra/features/therapy/presentation/widgets/change_therapist_chat/change_therapist_message_box.dart';

class PreferenceQuestionBaseBox extends StatefulWidget {
  const PreferenceQuestionBaseBox({
    Key? key,
    required this.question,
  }) : super(key: key);

  final TherapyPreferenceMessageModel question;

  @override
  State<PreferenceQuestionBaseBox> createState() =>
      _PreferenceQuestionBaseBoxState();
}

class _PreferenceQuestionBaseBoxState extends State<PreferenceQuestionBaseBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // constraints:  BoxConstraints(maxWidth: AppUtils.getDeviceSize(context).width*0.5 ),
            alignment: Alignment.centerLeft,
            // padding: const EdgeInsets.symmetric(vertical: 0),
            child: PreferenceQuestionBox(
              question: widget.question,
            )),
        if (widget.question.therapyMessageType ==
            TherapyMessageType.updatePreferenceMessage)
          Container(
              // constraints:  BoxConstraints(maxWidth: AppUtils.getDeviceSize(context).width*0.5 ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 5),
              child: PreferenceAnswerBox(
                question: widget.question,
              )),
        if (widget.question.therapyMessageType ==
            TherapyMessageType.changeTherapistMessage)
          Container(
              // constraints:  BoxConstraints(maxWidth: AppUtils.getDeviceSize(context).width*0.5 ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 5),
              child: ChangeTherapistAnswerWidget(
                question: widget.question,
              )),
      ],
    );
  }

// bool get isSender => true;
}
