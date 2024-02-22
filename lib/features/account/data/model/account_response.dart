// To parse this JSON data, do
//
//     final accountResponse = accountResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

AccountResponse accountResponseFromJson(String str) => AccountResponse.fromJson(json.decode(str));

String accountResponseToJson(AccountResponse data) => json.encode(data.toJson());

class AccountResponse {
  final String message;
  final MentraUser data;
  final bool success;
  final int code;

  AccountResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  AccountResponse copyWith({
    String? message,
    MentraUser? data,
    bool? success,
    int? code,
  }) =>
      AccountResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory AccountResponse.fromJson(Map<String, dynamic> json) => AccountResponse(
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


