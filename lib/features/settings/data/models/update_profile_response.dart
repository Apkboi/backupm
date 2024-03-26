// To parse this JSON data, do
//
//     final updateProfileEndpoint = updateProfileEndpointFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

UpdateProfileResponse updateProfileEndpointFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileEndpointToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  final String message;
  final MentraUser data;
  final bool success;
  final int code;

  UpdateProfileResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UpdateProfileResponse copyWith({
    String? message,
    MentraUser? data,
    bool? success,
    int? code,
  }) =>
      UpdateProfileResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
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


