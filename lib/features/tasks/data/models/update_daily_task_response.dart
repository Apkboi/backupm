// To parse this JSON data, do
//
//     final updateDailyTaskResponse = updateDailyTaskResponseFromJson(jsonString);

import 'dart:convert';

UpdateDailyTaskResponse updateDailyTaskResponseFromJson(String str) => UpdateDailyTaskResponse.fromJson(json.decode(str));

String updateDailyTaskResponseToJson(UpdateDailyTaskResponse data) => json.encode(data.toJson());

class UpdateDailyTaskResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  UpdateDailyTaskResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory UpdateDailyTaskResponse.fromJson(Map<String, dynamic> json) => UpdateDailyTaskResponse(
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
  final String title;
  final String task;
  final String subText;
  final String status;
  final bool hasDoneTask;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.title,
    required this.task,
    required this.subText,
    required this.status,
    required this.hasDoneTask,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
