// To parse this JSON data, do
//
//     final getPromptsCategoryResponse = getPromptsCategoryResponseFromJson(jsonString);

import 'dart:convert';

GetPromptsCategoryResponse getPromptsCategoryResponseFromJson(String str) =>
    GetPromptsCategoryResponse.fromJson(json.decode(str));

String getPromptsCategoryResponseToJson(GetPromptsCategoryResponse data) =>
    json.encode(data.toJson());

class GetPromptsCategoryResponse {
  final String message;
  final List<PromptCategory> data;
  final bool success;
  final int code;

  GetPromptsCategoryResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetPromptsCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetPromptsCategoryResponse(
        message: json["message"],
        data: List<PromptCategory>.from(json["data"].map((x) => PromptCategory.fromJson(x))),
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

class PromptCategory {
  final int id;
  final String title;
  final String backgroundColor;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  PromptCategory({
    required this.id,
    required this.title,
    required this.backgroundColor,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PromptCategory.fromJson(Map<String, dynamic> json) => PromptCategory(
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
