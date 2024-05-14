// To parse this JSON data, do
//
//     final createSessionPayload = createSessionPayloadFromJson(jsonString);

import 'dart:convert';

CreateSessionPayload createSessionPayloadFromJson(String str) =>
    CreateSessionPayload.fromJson(json.decode(str));

String createSessionPayloadToJson(CreateSessionPayload data) =>
    json.encode(data.toJson());

class CreateSessionPayload {
  final DateTime date;
  final String time;
  final List focus;
  final String note;
  final String? sessionId;

  CreateSessionPayload({
    required this.date,
    required this.time,
    required this.focus,
    required this.note,
    required this.sessionId,
  });

  CreateSessionPayload copyWith({
    DateTime? date,
    String? time,
    List? focus,
    String? note,
    String? sessionId,
  }) =>
      CreateSessionPayload(
        date: date ?? this.date,
        time: time ?? this.time,
        focus: focus ?? this.focus,
        note: note ?? this.note,
        sessionId: sessionId ?? this.sessionId,
      );

  factory CreateSessionPayload.fromJson(Map<String, dynamic> json) =>
      CreateSessionPayload(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        focus: json["focus"],
        note: json["note"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "focus": List<dynamic>.from(focus.map((x) => x)),
        "note": note,
        "session_id": sessionId,
      };

  // Factory method to create an empty instance
  factory CreateSessionPayload.empty() {
    return CreateSessionPayload(
      date: DateTime.now(),
      time: '',
      focus: [],
      note: '',
      sessionId: '',
    );
  }
}
