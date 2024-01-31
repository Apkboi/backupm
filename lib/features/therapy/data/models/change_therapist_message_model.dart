import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';

class ChangeTherapistMessageModel {
  final ChangeTherapistMessageType messageType;
  final SuggestedTherapist? therapist;
  final bool isSender;
  final List<String> message;
  final DateTime time;

  ChangeTherapistMessageModel(
      {required this.messageType,
      this.therapist,
      required this.isSender,
      required this.message,
      required this.time});
}

enum ChangeTherapistMessageType {
  processing,
  reply,
  retry,
  therapistSuggestion,
}
