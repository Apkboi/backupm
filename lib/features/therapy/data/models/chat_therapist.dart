// To parse this JSON data, do
//
//     final chatTherapist = chatTherapistFromJson(jsonString);

import 'dart:convert';

ChatTherapist chatTherapistFromJson(String str) => ChatTherapist.fromJson(json.decode(str));

String chatTherapistToJson(ChatTherapist data) => json.encode(data.toJson());

class ChatTherapist {
  final String avatarId;
  final String fullName;
  final DateTime createdAt;
  final String phoneNumber;
  final int id;
  final dynamic userId;
  final String title;

  ChatTherapist({
    required this.avatarId,
    required this.fullName,
    required this.createdAt,
    required this.phoneNumber,
    required this.id,
    required this.userId,
    required this.title,
  });

  factory ChatTherapist.fromJson(Map<String, dynamic> json) => ChatTherapist(
    avatarId: json["avatar_id"],
    fullName: json["full_name"],
    createdAt: DateTime.parse(json["created_at"]),
    phoneNumber: json["phone_number"],
    id: json["id"],
    title: json["title"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "avatar_id": avatarId,
    "full_name": fullName,
    "created_at": createdAt.toIso8601String(),
    "phone_number": phoneNumber,
    "id": id,
    "user_id": userId,
    "title": title,
  };
}
