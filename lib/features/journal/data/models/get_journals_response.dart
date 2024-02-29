// To parse this JSON data, do
//
//     final getJournalsResponse = getJournalsResponseFromJson(jsonString);

import 'dart:convert';

GetJournalsResponse getJournalsResponseFromJson(String str) =>
    GetJournalsResponse.fromJson(json.decode(str));

String getJournalsResponseToJson(GetJournalsResponse data) =>
    json.encode(data.toJson());

class GetJournalsResponse {
  final String message;
  final List<GuidedJournal> data;
  final bool success;
  final int code;

  GetJournalsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetJournalsResponse copyWith({
    String? message,
    List<GuidedJournal>? data,
    bool? success,
    int? code,
  }) =>
      GetJournalsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetJournalsResponse.fromJson(Map<String, dynamic> json) =>
      GetJournalsResponse(
        message: json["message"],
        data: List<GuidedJournal>.from(
            json["data"].map((x) => GuidedJournal.fromJson(x))),
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

class GuidedJournal {
  final int id;
  final GuidedPrompt? guidedPrompt;
  final dynamic body;
  final dynamic status;
  final dynamic createdAt;
  final DateTime updatedAt;

  GuidedJournal({
    required this.id,
    required this.guidedPrompt,
    required this.body,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  GuidedJournal copyWith({
    int? id,
    GuidedPrompt? guidedPrompt,
    String? body,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      GuidedJournal(
        id: id ?? this.id,
        guidedPrompt: guidedPrompt ?? this.guidedPrompt,
        body: body ?? this.body,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GuidedJournal.fromJson(Map<String, dynamic> json) => GuidedJournal(
        id: json["id"],
        guidedPrompt: json["guided_prompt"] == null
            ? null
            : GuidedPrompt.fromJson(json["guided_prompt"]),
        body: json["body"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guided_prompt": guidedPrompt?.toJson(),
        "body": body,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class GuidedPrompt {
  final int id;
  final String title;
  final String content;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  GuidedPrompt({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  GuidedPrompt copyWith({
    int? id,
    String? title,
    String? content,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      GuidedPrompt(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GuidedPrompt.fromJson(Map<String, dynamic> json) => GuidedPrompt(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
