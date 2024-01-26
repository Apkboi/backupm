// To parse this JSON data, do
//
//     final fetchTimeSlotsResponse = fetchTimeSlotsResponseFromJson(jsonString);

import 'dart:convert';

FetchTimeSlotsResponse fetchTimeSlotsResponseFromJson(String str) => FetchTimeSlotsResponse.fromJson(json.decode(str));

String fetchTimeSlotsResponseToJson(FetchTimeSlotsResponse data) => json.encode(data.toJson());

class FetchTimeSlotsResponse {
  final String message;
  final Map<String, Datum> data;
  final bool success;
  final int code;

  FetchTimeSlotsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  FetchTimeSlotsResponse copyWith({
    String? message,
    Map<String, Datum>? data,
    bool? success,
    int? code,
  }) =>
      FetchTimeSlotsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory FetchTimeSlotsResponse.fromJson(Map<String, dynamic> json) => FetchTimeSlotsResponse(
    message: json["message"],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "success": success,
    "code": code,
  };
}

class Datum {
  final String startTime;
  final String stopTime;
  final int duration;

  Datum({
    required this.startTime,
    required this.stopTime,
    required this.duration,
  });

  Datum copyWith({
    String? startTime,
    String? stopTime,
    int? duration,
  }) =>
      Datum(
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
        duration: duration ?? this.duration,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    startTime: json["start_time"],
    stopTime: json["stop_time"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "start_time": startTime,
    "stop_time": stopTime,
    "duration": duration,
  };
}