// To parse this JSON data, do
//
//     final saveJournalResponse = saveJournalResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/journal/data/models/get_journals_response.dart';

SaveJournalResponse saveJournalResponseFromJson(String str) =>
    SaveJournalResponse.fromJson(json.decode(str));

String saveJournalResponseToJson(SaveJournalResponse data) =>
    json.encode(data.toJson());

class SaveJournalResponse {
  final String message;
  final GuidedJournal data;
  final bool success;
  final int code;

  SaveJournalResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  SaveJournalResponse copyWith({
    String? message,
    GuidedJournal? data,
    bool? success,
    int? code,
  }) =>
      SaveJournalResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory SaveJournalResponse.fromJson(Map<String, dynamic> json) =>
      SaveJournalResponse(
        message: json["message"],
        data: GuidedJournal.fromJson(json["data"]),
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
