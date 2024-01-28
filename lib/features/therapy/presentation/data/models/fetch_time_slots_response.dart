// To parse this JSON data, do
//
//     final fetchTimeSlotsResponse = fetchTimeSlotsResponseFromJson(jsonString);

import 'dart:convert';

FetchTimeSlotsResponse fetchTimeSlotsResponseFromJson(String str) =>
    FetchTimeSlotsResponse.fromJson(json.decode(str));

String fetchTimeSlotsResponseToJson(FetchTimeSlotsResponse data) =>
    json.encode(data.toJson());

class FetchTimeSlotsResponse {
  final String message;
  final dynamic data;
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
    Map<String, TimeSlot>? data,
    bool? success,
    int? code,
  }) =>
      FetchTimeSlotsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory FetchTimeSlotsResponse.fromJson(Map<String, dynamic> json) =>
      FetchTimeSlotsResponse(
        message: json["message"],
        data: json["data"] is List
            ? []
            : Map.from(json["data"]).map(
                (k, v) => MapEntry<String, TimeSlot>(k, TimeSlot.fromJson(v))),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "success": success,
        "code": code,
      };

  List<TimeSlot> getDataAsList() {
    if (data is List) {
      // If the data is already a list, return it
      return List<TimeSlot>.from(data);

    } else if (data is Map<String, TimeSlot>) {
      // If the data is a map, convert it to a list of TimeSlot objects
      return (data as Map<String, TimeSlot>)
          .entries
          .map((entry) => TimeSlot.fromJson(entry.value.toJson()))
          .toList();
    } else {
      // Return an empty list if the data is not recognized
      return [];
    }
  }
}

class TimeSlot {
  final String startTime;
  final String stopTime;
  final int duration;

  TimeSlot({
    required this.startTime,
    required this.stopTime,
    required this.duration,
  });

  TimeSlot copyWith({
    String? startTime,
    String? stopTime,
    int? duration,
  }) =>
      TimeSlot(
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
        duration: duration ?? this.duration,
      );

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
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
