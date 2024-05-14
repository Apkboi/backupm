// To parse this JSON data, do
//
//     final getMessagesResponse = getMessagesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/therapy/data/models/send_message_response.dart';

GetMessagesResponse getMessagesResponseFromJson(String str) =>
    GetMessagesResponse.fromJson(json.decode(str));

String getMessagesResponseToJson(GetMessagesResponse data) =>
    json.encode(data.toJson());

class GetMessagesResponse {
  final String message;
  final List<ChatMessage> data;
  final bool success;
  final int code;

  GetMessagesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetMessagesResponse.fromJson(Map<String, dynamic> json) =>
      GetMessagesResponse(
        message: json["message"],
        data: List<ChatMessage>.from(
            json["data"].map((x) => ChatMessage.fromJson(x))),
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
