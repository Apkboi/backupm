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
  final Category category;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  JournalPrompt({
    required this.id,
    required this.category,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JournalPrompt.fromJson(Map<String, dynamic> json) => JournalPrompt(
    id: json["id"],
    category: Category.fromJson(json["category"]),
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category.toJson(),
    "content": content,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Category {
  final int id;
  final String title;
  final String backgroundColor;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.title,
    required this.backgroundColor,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    backgroundColor: json["background_color"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "background_color": backgroundColor,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
