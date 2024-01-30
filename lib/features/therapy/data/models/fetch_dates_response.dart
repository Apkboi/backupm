// To parse this JSON data, do
//
//     final fetchDatesResponse = fetchDatesResponseFromJson(jsonString);

import 'dart:convert';

FetchDatesResponse fetchDatesResponseFromJson(String str) => FetchDatesResponse.fromJson(json.decode(str));

String fetchDatesResponseToJson(FetchDatesResponse data) => json.encode(data.toJson());

class FetchDatesResponse {
  final String message;
  final List<DateTime> data;
  final bool success;
  final int code;

  FetchDatesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  FetchDatesResponse copyWith({
    String? message,
    List<DateTime>? data,
    bool? success,
    int? code,
  }) =>
      FetchDatesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory FetchDatesResponse.fromJson(Map<String, dynamic> json) => FetchDatesResponse(
    message: json["message"],
    data: List<DateTime>.from(json["data"].map((x) => DateTime.parse(x))),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    "success": success,
    "code": code,
  };
}
