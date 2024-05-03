// To parse this JSON data, do
//
//     final getCurrentSessionRsponse = getCurrentSessionRsponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

GetCurrentSessionRsponse getCurrentSessionRsponseFromJson(String str) =>
    GetCurrentSessionRsponse.fromJson(json.decode(str));

String getCurrentSessionRsponseToJson(GetCurrentSessionRsponse data) =>
    json.encode(data.toJson());

class GetCurrentSessionRsponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  GetCurrentSessionRsponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetCurrentSessionRsponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      GetCurrentSessionRsponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetCurrentSessionRsponse.fromJson(Map<String, dynamic> json) =>
      GetCurrentSessionRsponse(
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
  final int id;

  // final MentraUser user;
  final String reference;
  final DateTime startsAt;
  final dynamic endsAt;
  final dynamic summary;
  final dynamic status;
  final List<AiMessage> messages;
  final bool isNew;
  final List<CStarterClass> conversationStarter;

  Data({
    required this.id,
    // required this.user,
    required this.reference,
    required this.startsAt,
    required this.endsAt,
    required this.summary,
    required this.status,
    required this.messages,
    required this.isNew,
    required this.conversationStarter,
  });

  Data copyWith({
    int? id,
    MentraUser? user,
    String? reference,
    DateTime? startsAt,
    dynamic endsAt,
    dynamic summary,
    dynamic status,
    bool? isNew,
    List<AiMessage>? messages,
    List<CStarterClass>? conversationStarter,
  }) =>
      Data(
        id: id ?? this.id,
        // user: user ?? this.user,
        reference: reference ?? this.reference,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        summary: summary ?? this.summary,
        status: status ?? this.status,
        messages: messages ?? this.messages,
        isNew: isNew ?? this.isNew,
        conversationStarter: conversationStarter ?? this.conversationStarter,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        // user: MentraUser.fromJson(json["user"]),
        reference: json["reference"],
        startsAt: DateTime.parse(json["starts_at"]),
        endsAt: json["ends_at"],
        summary: json["summary"],
        status: json["status"],
        isNew: json["is_new"],
        messages: List<AiMessage>.from(
            json["messages"].map((x) => AiMessage.fromJson(x))),
        conversationStarter: List<CStarterClass>.from(
            json["messages"].map((x) => CStarterClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "user": user.toJson(),
        "reference": reference,
        "starts_at": startsAt.toIso8601String(),
        "ends_at": endsAt,
        "summary": summary,
        "status": status,
        "is_new": isNew,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "conversaton_starter":
            List<dynamic>.from(conversationStarter.map((x) => x.toJson())),
      };
}

class AiMessage {
  final String user;
  final String prompt;
  final String inputType;
  final List suggestion;
  final DateTime createdAt;

  AiMessage({
    required this.user,
    required this.prompt,
    required this.inputType,
    required this.suggestion,
    required this.createdAt,
  });

  AiMessage copyWith({
    String? user,
    String? prompt,
    String? inputType,
    List? suggestion,
    DateTime? createdAt,
  }) =>
      AiMessage(
        user: user ?? this.user,
        prompt: prompt ?? this.prompt,
        suggestion: suggestion ?? this.suggestion,
        inputType: inputType ?? this.inputType,
        createdAt: createdAt ?? this.createdAt,
      );

  factory AiMessage.fromJson(Map<String, dynamic> json) => AiMessage(
        user: json["user"],
        prompt: json["prompt"],
        suggestion: json["suggestions"] == null
            ? []
            : List.from(
                json["suggestions"],
              ),
        inputType: json["input_type"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "prompt": prompt,
        "input_type": inputType,
        "suggestions": suggestion,
        "created_at": createdAt.toIso8601String(),
      };
}

class CStarterClass {
  final String content;
  final List<String> options;

  CStarterClass({required this.content, required this.options});

  factory CStarterClass.fromJson(Map<String, dynamic> json) {
    return CStarterClass(
      content: json['content'] ?? '',
      options: List<String>.from(json['options'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'options': options,
    };
  }
}
