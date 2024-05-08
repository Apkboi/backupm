import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';

class TherapyPreferenceMessageModel {
  List question;
  String? answer;
  List options;
  String key;
  int id;
  bool isTyping;
  TherapyMessageType therapyMessageType;
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
      required this.id});

  factory TherapyPreferenceMessageModel.typing() =>
      TherapyPreferenceMessageModel(
          question: [], options: [], key: '', id: 200, isTyping: true);
}

enum TherapyPreferenceIntent { updatePreference, changeTherapist }

enum TherapyMessageType { updatePreferenceMessage, changeTherapistMessage }
