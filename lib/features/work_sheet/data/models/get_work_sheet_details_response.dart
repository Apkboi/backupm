// To parse this JSON data, do
//
//     final getWorkSheetDetailsResponse = getWorkSheetDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/work_sheet/data/models/get_all_work_sheet_response.dart';

GetWorkSheetDetailsResponse getWorkSheetDetailsResponseFromJson(String str) => GetWorkSheetDetailsResponse.fromJson(json.decode(str));

String getWorkSheetDetailsResponseToJson(GetWorkSheetDetailsResponse data) => json.encode(data.toJson());

class GetWorkSheetDetailsResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  GetWorkSheetDetailsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetWorkSheetDetailsResponse.fromJson(Map<String, dynamic> json) => GetWorkSheetDetailsResponse(
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
  final Therapist user;
  final Therapist therapist;
  final String title;
  final String description;
  final String type;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<WeeklyTask> weeklyTasks;

  Data({
    required this.id,
    required this.user,
    required this.therapist,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.weeklyTasks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    user: Therapist.fromJson(json["user"]),
    therapist: Therapist.fromJson(json["therapist"]),
    title: json["title"],
    description: json["description"],
    type: json["type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    weeklyTasks: List<WeeklyTask>.from(json["weekly_tasks"].map((x) => WeeklyTask.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "therapist": therapist.toJson(),
    "title": title,
    "description": description,
    "type": type,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "weekly_tasks": List<dynamic>.from(weeklyTasks.map((x) => x.toJson())),
  };
}

class Therapist {
  final int id;
  final String avatar;
  final String name;
  final String email;

  Therapist({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "name": name,
    "email": email,
  };
}


class Task {
  final int id;
  final int workSheetWeekDayId;
  final String time;
  final String task;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    required this.id,
    required this.workSheetWeekDayId,
    required this.time,
    required this.task,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    workSheetWeekDayId: json["work_sheet_week_day_id"],
    time: json["time"],
    task: json["task"],
    completed: json["completed"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "work_sheet_week_day_id": workSheetWeekDayId,
    "time": time,
    "task": task,
    "completed": completed,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
