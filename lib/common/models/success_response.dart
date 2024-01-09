// To parse this JSON data, do
//
//     final successResponse = successResponseFromJson(jsonString);

import 'dart:convert';

SuccessResponse successResponseFromJson(String str) => SuccessResponse.fromJson(json.decode(str));

String successResponseToJson(SuccessResponse data) => json.encode(data.toJson());

class SuccessResponse {
  final String msg;
  final dynamic data;
  final bool success;
  final int code;

  SuccessResponse({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  SuccessResponse copyWith({
    String? msg,
    dynamic data,
    bool? success,
    int? code,
  }) =>
      SuccessResponse(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => SuccessResponse(
    msg: json["msg"],
    data: json["data"],
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": data,
    "success": success,
    "code": code,
  };
}
