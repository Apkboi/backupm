// To parse this JSON data, do
//
//     final createSessionPayload = createSessionPayloadFromJson(jsonString);

import 'dart:convert';

CreateSessionPayload createSessionPayloadFromJson(String str) => CreateSessionPayload.fromJson(json.decode(str));

String createSessionPayloadToJson(CreateSessionPayload data) => json.encode(data.toJson());

class CreateSessionPayload {
  final DateTime date;
  final String time;
  final String focus;
  final String note;

  CreateSessionPayload({
    required this.date,
    required this.time,
    required this.focus,
    required this.note,
  });

  CreateSessionPayload copyWith({
    DateTime? date,
    String? time,
    String? focus,
    String? note,
  }) =>
      CreateSessionPayload(
        date: date ?? this.date,
        time: time ?? this.time,
        focus: focus ?? this.focus,
        note: note ?? this.note,
      );

  factory CreateSessionPayload.fromJson(Map<String, dynamic> json) => CreateSessionPayload(
    date: DateTime.parse(json["date"]),
    time: json["time"],
    focus: json["focus"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "focus": focus,
    "note": note,
  };

  // Factory method to create an empty instance
  factory CreateSessionPayload.empty() {
    return CreateSessionPayload(
      date: DateTime.now(),
      time: '',
      focus: '',
      note: '',
    );
  }
}
