// To parse this JSON data, do

//     final getNotificationsResponse = getNotificationsResponseFromJson(jsonString);
import 'dart:convert';

import 'package:mentra/features/therapy/data/models/chat_therapist.dart';

GetNotificationsResponse getNotificationsResponseFromJson(String str) =>
    GetNotificationsResponse.fromJson(json.decode(str));

String getNotificationsResponseToJson(GetNotificationsResponse data) =>
    json.encode(data.toJson());

class GetNotificationsResponse {
  final String message;
  final List<MentraNotification> data;
  final bool success;
  final int code;

  GetNotificationsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetNotificationsResponse copyWith({
    String? message,
    List<MentraNotification>? data,
    bool? success,
    int? code,
  }) =>
      GetNotificationsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      GetNotificationsResponse(
        message: json["message"],
        data: List<MentraNotification>.from(
            json["data"].map((x) => MentraNotification.fromJson(x))),
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

MentraNotification mentraNotificationFromJson(String str) =>
    MentraNotification.fromJson(json.decode(str));

String mentraNotificationToJson(MentraNotification data) =>
    json.encode(data.toJson());

class MentraNotification {
  final String id;
  final dynamic title;
  final dynamic message;
  final dynamic type;
  final dynamic dataId;
  final Extra? extra;
  dynamic readAt;
  final DateTime createdAt;

  MentraNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.dataId,
    required this.extra,
    required this.readAt,
    required this.createdAt,
  });

  factory MentraNotification.fromJson(Map<String, dynamic> json) =>
      MentraNotification(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        type: json["type"],
        dataId: json["data_id"],
        extra: json["extra"] is List
            ? null
            : json["extra"] == null
                ? null
                : Extra.fromJson(json["extra"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "type": type,
        "data_id": dataId,
        "extra": extra?.toJson(),
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
      };
}

class Extra {
  final ChatTherapist? therapist;

  Extra({
    required this.therapist,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        therapist: json["therapist"] == null
            ? null
            : ChatTherapist.fromJson(json["therapist"]),
      );

  Map<String, dynamic> toJson() => {
        "therapist": therapist?.toJson(),
      };
}
