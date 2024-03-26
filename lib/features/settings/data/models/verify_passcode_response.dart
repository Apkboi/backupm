// To parse this JSON data, do
//
//     final verifyPasscodeResponse = verifyPasscodeResponseFromJson(jsonString);

import 'dart:convert';

VerifyPasscodeResponse verifyPasscodeResponseFromJson(String str) => VerifyPasscodeResponse.fromJson(json.decode(str));

String verifyPasscodeResponseToJson(VerifyPasscodeResponse data) => json.encode(data.toJson());

class VerifyPasscodeResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  VerifyPasscodeResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  VerifyPasscodeResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      VerifyPasscodeResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory VerifyPasscodeResponse.fromJson(Map<String, dynamic> json) => VerifyPasscodeResponse(
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
  final String hash;

  Data({
    required this.hash,
  });

  Data copyWith({
    String? hash,
  }) =>
      Data(
        hash: hash ?? this.hash,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
  };
}
