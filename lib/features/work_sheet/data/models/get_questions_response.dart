// To parse this JSON data, do
//
//     final getQuestionsResponse = getQuestionsResponseFromJson(jsonString);

import 'dart:convert';

GetQuestionsResponse getQuestionsResponseFromJson(String str) => GetQuestionsResponse.fromJson(json.decode(str));

String getQuestionsResponseToJson(GetQuestionsResponse data) => json.encode(data.toJson());

class GetQuestionsResponse {
  final String message;
  final List<Datum> data;
  final bool success;
  final int code;

  GetQuestionsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetQuestionsResponse.fromJson(Map<String, dynamic> json) => GetQuestionsResponse(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  final int id;
  final Therapist user;
  final Therapist therapist;
  final String title;
  final String description;
  final String type;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<WeeklyTask>? weeklyTasks;
  final List<Question>? questions;

  Datum({
    required this.id,
    required this.user,
    required this.therapist,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.weeklyTasks,
    this.questions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    user: Therapist.fromJson(json["user"]),
    therapist: Therapist.fromJson(json["therapist"]),
    title: json["title"],
    description: json["description"],
    type: json["type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    weeklyTasks: json["weekly_tasks"] == null ? [] : List<WeeklyTask>.from(json["weekly_tasks"]!.map((x) => WeeklyTask.fromJson(x))),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
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
    "weekly_tasks": weeklyTasks == null ? [] : List<dynamic>.from(weeklyTasks!.map((x) => x.toJson())),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  final int id;
  final int workSheetId;
  final String question;
  final dynamic answer;
  final DateTime createdAt;
  final DateTime updatedAt;

  Question({
    required this.id,
    required this.workSheetId,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    workSheetId: json["work_sheet_id"],
    question: json["question"],
    answer: json["answer"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "work_sheet_id": workSheetId,
    "question": question,
    "answer": answer,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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

class WeeklyTask {
  final int id;
  final int workSheetId;
  final String day;
  final List<Task> tasks;
  final DateTime createdAt;
  final DateTime updatedAt;

  WeeklyTask({
    required this.id,
    required this.workSheetId,
    required this.day,
    required this.tasks,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WeeklyTask.fromJson(Map<String, dynamic> json) => WeeklyTask(
    id: json["id"],
    workSheetId: json["work_sheet_id"],
    day: json["day"],
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "work_sheet_id": workSheetId,
    "day": day,
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
