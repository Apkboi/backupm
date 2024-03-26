// To parse this JSON data, do
//
//     final loginPreviewResponse = loginPreviewResponseFromJson(jsonString);

import 'dart:convert';

LoginPreviewResponse loginPreviewResponseFromJson(String str) => LoginPreviewResponse.fromJson(json.decode(str));

String loginPreviewResponseToJson(LoginPreviewResponse data) => json.encode(data.toJson());

class LoginPreviewResponse {
  final String message;
  final UserPreview data;
  final bool success;
  final int code;

  LoginPreviewResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  LoginPreviewResponse copyWith({
    String? message,
    UserPreview? data,
    bool? success,
    int? code,
  }) =>
      LoginPreviewResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory LoginPreviewResponse.fromJson(Map<String, dynamic> json) => LoginPreviewResponse(
    message: json["message"],
    data: UserPreview.fromJson(json["data"]),
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

class UserPreview {
  final String avatar;
  final String name;
  final String role;
  final dynamic avatarBackgroundColor;
  final String email;

  UserPreview({
    required this.avatar,
    required this.name,
    required this.role,
    required this.avatarBackgroundColor,
    required this.email,
  });

  UserPreview copyWith({
    String? avatar,
    String? name,
    String? role,
    dynamic avatarBackgroundColor,
    String? email,
  }) =>
      UserPreview(
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor: avatarBackgroundColor ?? this.avatarBackgroundColor,
        email: email ?? this.email,
      );

  factory UserPreview.fromJson(Map<String, dynamic> json) => UserPreview(
    avatar: json["avatar"],
    name: json["name"],
    role: json["role"],
    avatarBackgroundColor: json["avatar_background_color"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "name": name,
    "role": role,
    "avatar_background_color": avatarBackgroundColor,
    "email": email,
  };
}
