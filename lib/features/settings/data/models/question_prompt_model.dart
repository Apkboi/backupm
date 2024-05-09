import 'package:mentra/features/settings/data/models/change_therapist_stage.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';

class TherapyPreferenceMessageModel {
  List question;
  String? answer;
  List options;
  String key;
  dynamic id;
  bool isTyping;
  TherapyMessageType therapyMessageType;
  ChangeTherapistStage changeTherapistStage;
  ChangeTherapistStage? nextChangeTherapistStage;
  SuggestedTherapist? suggestedTherapist;
  DateTime? questionTime = DateTime.now();
  DateTime? answerTime = DateTime.now();

  TherapyPreferenceMessageModel(
      {required this.question,
      this.answer,
      // this.questionTime,
      this.isTyping = false,
      required this.options,
      required this.key,
      this.suggestedTherapist,
      this.therapyMessageType = TherapyMessageType.updatePreferenceMessage,
      this.changeTherapistStage = ChangeTherapistStage.initial,
      this.nextChangeTherapistStage,
      required this.id});

  factory TherapyPreferenceMessageModel.typing() =>
      TherapyPreferenceMessageModel(
          question: [], options: [], key: '', id: 200, isTyping: true);



}

enum TherapyPreferenceIntent { updatePreference, changeTherapist,selectTherapist }

enum TherapyMessageType { updatePreferenceMessage, changeTherapistMessage }
