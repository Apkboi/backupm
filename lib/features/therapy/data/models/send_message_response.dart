// To parse this JSON data, do
//
//     final sendMessageRsponse = sendMessageRsponseFromJson(jsonString);

import 'dart:convert';

SendMessageRsponse sendMessageRsponseFromJson(String str) => SendMessageRsponse.fromJson(json.decode(str));

String sendMessageRsponseToJson(SendMessageRsponse data) => json.encode(data.toJson());

class SendMessageRsponse {
  final String message;
  final ChatMessage data;
  final bool success;
  final int code;

  SendMessageRsponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory SendMessageRsponse.fromJson(Map<String, dynamic> json) => SendMessageRsponse(
    message: json["message"],
    data: ChatMessage.fromJson(json["data"]),
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

class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final bool isTherapist;
  final int conversationId;
  final String message;
  final dynamic read;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.isTherapist,
    required this.conversationId,
    required this.message,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    isTherapist: json["is_therapist"],
    conversationId: json["conversation_id"],
    message: json["message"],
    read: json["read"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "is_therapist": isTherapist,
    "conversation_id": conversationId,
    "message": message,
    "read": read,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
