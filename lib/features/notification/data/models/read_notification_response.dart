// To parse this JSON data, do
//
//     final readNotificationResponse = readNotificationResponseFromJson(jsonString);

import 'dart:convert';

ReadNotificationResponse readNotificationResponseFromJson(String str) => ReadNotificationResponse.fromJson(json.decode(str));

String readNotificationResponseToJson(ReadNotificationResponse data) => json.encode(data.toJson());

class ReadNotificationResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  ReadNotificationResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  ReadNotificationResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      ReadNotificationResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory ReadNotificationResponse.fromJson(Map<String, dynamic> json) => ReadNotificationResponse(
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
  final String id;
  final String title;
  final String message;
  final String type;
  final dynamic dataId;
  final DateTime readAt;
  final DateTime createdAt;

  Data({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.dataId,
    required this.readAt,
    required this.createdAt,
  });

  Data copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    dynamic dataId,
    DateTime? readAt,
    DateTime? createdAt,
  }) =>
      Data(
        id: id ?? this.id,
        title: title ?? this.title,
        message: message ?? this.message,
        type: type ?? this.type,
        dataId: dataId ?? this.dataId,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    message: json["message"],
    type: json["type"],
    dataId: json["data_id"],
    readAt: DateTime.parse(json["read_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,
    "type": type,
    "data_id": dataId,
    "read_at": readAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
