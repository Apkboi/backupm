// To parse this JSON data, do
//
//     final conversationStarterResponse = conversationStarterResponseFromJson(jsonString);

import 'dart:convert';

ConversationStarterResponse conversationStarterResponseFromJson(String str) => ConversationStarterResponse.fromJson(json.decode(str));

String conversationStarterResponseToJson(ConversationStarterResponse data) => json.encode(data.toJson());

class ConversationStarterResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  ConversationStarterResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  ConversationStarterResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      ConversationStarterResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory ConversationStarterResponse.fromJson(Map<String, dynamic> json) => ConversationStarterResponse(
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
  final String title;
  final String message;
  final String backgroundColor;

  Data({
    required this.title,
    required this.message,
    required this.backgroundColor,
  });

  Data copyWith({
    String? title,
    String? message,
    String? backgroundColor,
  }) =>
      Data(
        title: title ?? this.title,
        message: message ?? this.message,
        backgroundColor: backgroundColor ?? this.backgroundColor,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    message: json["message"],
    backgroundColor: json["background_color"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "background_color": backgroundColor,
  };
}
