// To parse this JSON data, do
//
//     final updateMoodCheckerResponse = updateMoodCheckerResponseFromJson(jsonString);

import 'dart:convert';

UpdateMoodCheckerResponse updateMoodCheckerResponseFromJson(String str) => UpdateMoodCheckerResponse.fromJson(json.decode(str));

String updateMoodCheckerResponseToJson(UpdateMoodCheckerResponse data) => json.encode(data.toJson());

class UpdateMoodCheckerResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  UpdateMoodCheckerResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory UpdateMoodCheckerResponse.fromJson(Map<String, dynamic> json) => UpdateMoodCheckerResponse(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "success": success,
    "code": code,
  };
}

class Data {
  final int id;
  final String mood;
  final dynamic comment;
  final dynamic status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.mood,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mood: json["mood"],
    comment: json["comment"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mood": mood,
    "comment": comment,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
