// To parse this JSON data, do
//
//     final uploadAvatarResponse = uploadAvatarResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

UploadAvatarResponse uploadAvatarResponseFromJson(String str) =>
    UploadAvatarResponse.fromJson(json.decode(str));

String uploadAvatarResponseToJson(UploadAvatarResponse data) =>
    json.encode(data.toJson());

class UploadAvatarResponse {
  final String message;
  final MentraUser data;
  final bool success;
  final int code;

  UploadAvatarResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UploadAvatarResponse copyWith({
    String? message,
    MentraUser? data,
    bool? success,
    int? code,
  }) =>
      UploadAvatarResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UploadAvatarResponse.fromJson(Map<String, dynamic> json) =>
      UploadAvatarResponse(
        message: json["message"],
        data: MentraUser.fromJson(json["data"]),
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


