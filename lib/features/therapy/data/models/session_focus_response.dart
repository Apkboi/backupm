// To parse this JSON data, do
//
//     final sessiionFocusREsponse = sessiionFocusREsponseFromJson(jsonString);

import 'dart:convert';

SessionFocusResponse sessiionFocusREsponseFromJson(String str) => SessionFocusResponse.fromJson(json.decode(str));

String sessiionFocusREsponseToJson(SessionFocusResponse data) => json.encode(data.toJson());

class SessionFocusResponse {
  final String message;
  final List<SessionFocus> data;
  final bool success;
  final int code;

  SessionFocusResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory SessionFocusResponse.fromJson(Map<String, dynamic> json) => SessionFocusResponse(
    message: json["message"],
    data: List<SessionFocus>.from(json["data"].map((x) => SessionFocus.fromJson(x))),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "code": code,
  };
}

class SessionFocus {
  final int id;
  final String name;
  final String description;
  final String status;
  final DateTime createdAt;

  SessionFocus({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory SessionFocus.fromJson(Map<String, dynamic> json) => SessionFocus(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}
