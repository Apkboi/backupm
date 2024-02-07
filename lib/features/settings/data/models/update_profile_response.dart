// To parse this JSON data, do
//
//     final updateProfileEndpoint = updateProfileEndpointFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileEndpointFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileEndpointToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  final String message;
  final Data data;
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
    Data? data,
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
  final String avatar;
  final String name;
  final String role;
  final dynamic avatarBackgroundColor;
  final String username;
  final String email;
  final String birthYear;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.avatar,
    required this.name,
    required this.role,
    required this.avatarBackgroundColor,
    required this.username,
    required this.email,
    required this.birthYear,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    dynamic avatarBackgroundColor,
    String? username,
    String? email,
    String? birthYear,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor: avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        birthYear: birthYear ?? this.birthYear,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    role: json["role"],
    avatarBackgroundColor: json["avatar_background_color"],
    username: json["username"],
    email: json["email"],
    birthYear: json["birth_year"],
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
