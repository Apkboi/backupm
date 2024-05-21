// To parse this JSON data, do
//
//     final submitQuestionairePayload = submitQuestionairePayloadFromJson(jsonString);

import 'dart:convert';

SubmitQuestionairePayload submitQuestionairePayloadFromJson(String str) =>
    SubmitQuestionairePayload.fromJson(json.decode(str));

String submitQuestionairePayloadToJson(SubmitQuestionairePayload data) =>
    json.encode(data.toJson());

class SubmitQuestionairePayload {
  final String worksheetId;
  final List<QuestionaireAnswer> data;

  SubmitQuestionairePayload({
    required this.worksheetId,
    required this.data,
  });

  factory SubmitQuestionairePayload.fromJson(Map<String, dynamic> json) =>
      SubmitQuestionairePayload(
        worksheetId: json["worksheet_id"],
        data: List<QuestionaireAnswer>.from(
            json["data"].map((x) => QuestionaireAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "worksheet_id": worksheetId,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class QuestionaireAnswer {
  final int worksheetQuestionId;
  final String answer;

  QuestionaireAnswer({
    required this.worksheetQuestionId,
    required this.answer,
  });

  factory QuestionaireAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionaireAnswer(
        worksheetQuestionId: json["worksheet_question_id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "worksheet_question_id": worksheetQuestionId,
        "answer": answer,
      };
}
