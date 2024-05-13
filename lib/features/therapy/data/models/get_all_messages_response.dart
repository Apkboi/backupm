// To parse this JSON data, do
//
//     final getAllMessagesResponse = getAllMessagesResponseFromJson(jsonString);

import 'dart:convert';

GetAllMessagesResponse getAllMessagesResponseFromJson(String str) => GetAllMessagesResponse.fromJson(json.decode(str));

String getAllMessagesResponseToJson(GetAllMessagesResponse data) => json.encode(data.toJson());

class GetAllMessagesResponse {
  final String message;
  final List<Datum> data;
  final bool success;
  final int code;

  GetAllMessagesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetAllMessagesResponse.fromJson(Map<String, dynamic> json) => GetAllMessagesResponse(
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
  final int senderId;
  final int receiverId;
  final int conversationId;
  final String message;
  final bool read;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.message,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    conversationId: json["conversation_id"],
    message: json["message"],
    read: json["read"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "sender_id": senderId,
    "receiver_id": receiverId,
    "conversation_id": conversationId,
    "message": message,
    "read": read,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
