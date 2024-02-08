// To parse this JSON data, do
//
//     final oauthResponse = oauthResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

OauthResponse oauthResponseFromJson(String str) =>
    OauthResponse.fromJson(json.decode(str));

String oauthResponseToJson(OauthResponse data) => json.encode(data.toJson());

class OauthResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  OauthResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  OauthResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      OauthResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory OauthResponse.fromJson(Map<String, dynamic> json) =>
      OauthResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() =>
      {
        "message": message,
        "data": data.toJson(),
        "success": success,
        "code": code,
      };

  AuthSuccessResponse get toAuthSuccessResponse =>
      AuthSuccessResponse(message: message,
          data: AuthSuccessData(token: data.token!, user: data.user!),
          success: success,
          code: code);

}

class Data {
  final String? token;
  final String? email;
  final String? provider;
  final MentraUser? user;
  final bool newUser;

  Data({
    required this.token,
    required this.email,
    required this.provider,
    required this.user,
    required this.newUser,
  });

  Data copyWith({
    String? token,
    String? provider,
    MentraUser? user,
    bool? newUser,
  }) =>
      Data(
        token: token ?? this.token,
        email: email ?? this.email,
        provider: provider ?? this.provider,
        user: user ?? this.user,
        newUser: newUser ?? this.newUser,
      );

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        token: json["token"],
        email: json["email"],
        provider: json["provider"],
        user: json["user"] == null ? null : MentraUser.fromJson(json["user"]),
        newUser: json["new_user"],
      );

  Map<String, dynamic> toJson() =>
      {
        "token": token,
        "email": email,
        "provider": provider,
        "user": user?.toJson(),
        "new_user": newUser,
      };


}
