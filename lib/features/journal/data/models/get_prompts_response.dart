// To parse this JSON data, do
//
//     final getPromptsResponse = getPromptsResponseFromJson(jsonString);

import 'dart:convert';

GetPromptsResponse getPromptsResponseFromJson(String str) => GetPromptsResponse.fromJson(json.decode(str));

String getPromptsResponseToJson(GetPromptsResponse data) => json.encode(data.toJson());

class GetPromptsResponse {
  final String message;
  final List<JournalPrompt> data;
  final bool success;
  final int code;

  GetPromptsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetPromptsResponse copyWith({
    String? message,
    List<JournalPrompt>? data,
    bool? success,
    int? code,
  }) =>
      GetPromptsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetPromptsResponse.fromJson(Map<String, dynamic> json) => GetPromptsResponse(
    message: json["message"],
    data: List<JournalPrompt>.from(json["data"].map((x) => JournalPrompt.fromJson(x))),
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

class JournalPrompt {
  final int id;
  final String title;
  final String content;
  final dynamic status;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic backgroundColor;

  JournalPrompt({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.backgroundColor,
  });

  JournalPrompt copyWith({
    int? id,
    String? title,
    String? content,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic backgroundColor,
  }) =>
      JournalPrompt(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        backgroundColor: backgroundColor ?? this.backgroundColor,
      );

  factory JournalPrompt.fromJson(Map<String, dynamic> json) => JournalPrompt(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    backgroundColor: json["background_color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "background_color": backgroundColor,
  };
}
