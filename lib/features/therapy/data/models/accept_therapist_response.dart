// To parse this JSON data, do
//
//     final acceptTherapistResponse = acceptTherapistResponseFromJson(jsonString);

import 'dart:convert';

AcceptTherapistResponse acceptTherapistResponseFromJson(String str) => AcceptTherapistResponse.fromJson(json.decode(str));

String acceptTherapistResponseToJson(AcceptTherapistResponse data) => json.encode(data.toJson());

class AcceptTherapistResponse {
  final String message;
  final int code;
  final bool success;
  final dynamic errorCode;
  final dynamic errorDebug;

  AcceptTherapistResponse({
    required this.message,
    required this.code,
    required this.success,
    required this.errorCode,
    required this.errorDebug,
  });

  AcceptTherapistResponse copyWith({
    String? message,
    int? code,
    bool? success,
    dynamic errorCode,
    dynamic errorDebug,
  }) =>
      AcceptTherapistResponse(
        message: message ?? this.message,
        code: code ?? this.code,
        success: success ?? this.success,
        errorCode: errorCode ?? this.errorCode,
        errorDebug: errorDebug ?? this.errorDebug,
      );

  factory AcceptTherapistResponse.fromJson(Map<String, dynamic> json) => AcceptTherapistResponse(
    message: json["message"],
    code: json["code"],
    success: json["success"],
    errorCode: json["error_code"],
    errorDebug: json["error_debug"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "success": success,
    "error_code": errorCode,
    "error_debug": errorDebug,
  };
}
