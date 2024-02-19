// To parse this JSON data, do
//
//     final authSuccessResponse = authSuccessResponseFromJson(jsonString);

import 'dart:convert';

AuthSuccessResponse authSuccessResponseFromJson(String str) => AuthSuccessResponse.fromJson(json.decode(str));

String authSuccessResponseToJson(AuthSuccessResponse data) => json.encode(data.toJson());

class AuthSuccessResponse {
  final String message;
  final AuthSuccessData data;
  final bool success;
  final int code;

  AuthSuccessResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  AuthSuccessResponse copyWith({
    String? message,
    AuthSuccessData? data,
    bool? success,
    int? code,
  }) =>
      AuthSuccessResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) => AuthSuccessResponse(
    message: json["message"],
    data: AuthSuccessData.fromJson(json["data"]),
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

class AuthSuccessData {
  final String token;
  final MentraUser user;

  AuthSuccessData({
    required this.token,
    required this.user,
  });

  AuthSuccessData copyWith({
    String? token,
    MentraUser? user,
  }) =>
      AuthSuccessData(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory AuthSuccessData.fromJson(Map<String, dynamic> json) => AuthSuccessData(
    token: json["token"],
    user: MentraUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}

class MentraUser {
  final int id;
  final String avatar;
  final String name;
  final String role;
  final dynamic avatarBackgroundColor;
  final String username;
  final String email;
  final String birthYear;
  final dynamic stripeCustomerId;
  final dynamic mesiboUserId;
  final dynamic mesiboUserToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  MentraUser({
    required this.id,
    required this.avatar,
    required this.name,
    required this.role,
    required this.avatarBackgroundColor,
    required this.username,
    required this.email,
    required this.birthYear,
     this.stripeCustomerId,
    required this.mesiboUserId,
    required this.mesiboUserToken,
    required this.createdAt,
    required this.updatedAt,
  });

  MentraUser copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    dynamic avatarBackgroundColor,
    String? username,
    String? email,
    String? birthYear,
    String? stripeCustomerId,
    dynamic mesiboUserId,
    dynamic mesiboUserToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      MentraUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor:
        avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        birthYear: birthYear ?? this.birthYear,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        mesiboUserId: mesiboUserId ?? this.mesiboUserId,
        mesiboUserToken: mesiboUserToken ?? this.mesiboUserToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MentraUser.fromJson(Map<String, dynamic> json) => MentraUser(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    role: json["role"],
    avatarBackgroundColor: json["avatar_background_color"],
    username: json["username"],
    email: json["email"],
    birthYear: json["birth_year"],
    stripeCustomerId: json["stripe_customer_id"],
    mesiboUserId: json["mesibo_user_id"],
    mesiboUserToken: json["mesibo_user_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "name": name,
    "role": role,
    "avatar_background_color": avatarBackgroundColor,
    "username": username,
    "email": email,
    "birth_year": birthYear,
    "stripe_customer_id": stripeCustomerId,
    "mesibo_user_id": mesiboUserId,
    "mesibo_user_token": mesiboUserToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
