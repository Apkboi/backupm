// To parse this JSON data, do
//
//     final getDailyTakResponse = getDailyTakResponseFromJson(jsonString);

import 'dart:convert';

GetDailyTakResponse getDailyTakResponseFromJson(String str) => GetDailyTakResponse.fromJson(json.decode(str));

String getDailyTakResponseToJson(GetDailyTakResponse data) => json.encode(data.toJson());

class GetDailyTakResponse {
  final String message;
  final List<DailyTaskModel> data;
  final bool success;
  final int code;

  GetDailyTakResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetDailyTakResponse.fromJson(Map<String, dynamic> json) => GetDailyTakResponse(
    message: json["message"],
    data: List<DailyTaskModel>.from(json["data"].map((x) => DailyTaskModel.fromJson(x))),
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

class DailyTaskModel {
  final int id;
  final String title;
  final String task;
  final String subText;
  final String status;
  final bool hasDoneTask;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyTaskModel({
    required this.id,
    required this.title,
    required this.task,
    required this.subText,
    required this.status,
    required this.hasDoneTask,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyTaskModel.fromJson(Map<String, dynamic> json) => DailyTaskModel(
    id: json["id"],
    title: json["title"],
    task: json["task"],
    subText: json["sub_text"],
    status: json["status"],
    hasDoneTask: json["has_done_task"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "task": task,
    "sub_text": subText,
    "status": status,
    "has_done_task": hasDoneTask,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
