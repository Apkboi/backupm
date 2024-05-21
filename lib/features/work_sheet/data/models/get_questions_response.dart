// To parse this JSON data, do
//
//     final getQuestionsResponse = getQuestionsResponseFromJson(jsonString);

import 'dart:convert';

GetQuestionsResponse getQuestionsResponseFromJson(String str) => GetQuestionsResponse.fromJson(json.decode(str));

String getQuestionsResponseToJson(GetQuestionsResponse data) => json.encode(data.toJson());

class GetQuestionsResponse {
  final String message;
  final List<Questionaire> data;
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
    data: List<Questionaire>.from(json["data"].map((x) => Questionaire.fromJson(x))),
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

class Questionaire {
  final int id;
  final dynamic workSheetId;
  final dynamic question;
  final dynamic answer;
  final DateTime createdAt;
  final DateTime updatedAt;

  Questionaire({
    required this.id,
    required this.workSheetId,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Questionaire.fromJson(Map<String, dynamic> json) => Questionaire(
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
