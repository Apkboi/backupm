class TherapyChatMessage {
  String message;
  DateTime time;
  bool isTherapist;
  dynamic media;
  String id;

  TherapyChatMessage(
      {required this.message,
      required this.time,
      required this.isTherapist,
      this.media,
      required this.id});
}
