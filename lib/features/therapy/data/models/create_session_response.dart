//
//     final createSessionResponse = createSessionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';

CreateSessionResponse createSessionResponseFromJson(String str) => CreateSessionResponse.fromJson(json.decode(str));

String createSessionResponseToJson(CreateSessionResponse data) => json.encode(data.toJson());

class CreateSessionResponse {
  final String message;
  final SessionDetails data;
  final bool success;
  final int code;

  CreateSessionResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  CreateSessionResponse copyWith({
    String? message,
    SessionDetails? data,
    bool? success,
    int? code,
  }) =>
      CreateSessionResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory CreateSessionResponse.fromJson(Map<String, dynamic> json) => CreateSessionResponse(
    message: json["message"],
    data: SessionDetails.fromJson(json["data"]),
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

class SessionDetails {
  final int id;
  final User user;
  final DataTherapist therapist;
  final String reference;
  final List<String> focus;
  final int duration;
  final String startsAt;
  final dynamic endsAt;
  final dynamic note;
  final dynamic status;
  final DateTime createdAt;
  final DateTime updatedAt;

  SessionDetails({
    required this.id,
    required this.user,
    required this.therapist,
    required this.reference,
    required this.focus,
    required this.duration,
    required this.startsAt,
    required this.endsAt,
    required this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  SessionDetails copyWith({
    int? id,
    User? user,
    DataTherapist? therapist,
    String? reference,
    List<String>? focus,
    int? duration,
    String? startsAt,
    dynamic endsAt,
    dynamic note,
    dynamic status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SessionDetails(
        id: id ?? this.id,
        user: user ?? this.user,
        therapist: therapist ?? this.therapist,
        reference: reference ?? this.reference,
        focus: focus ?? this.focus,
        duration: duration ?? this.duration,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        note: note ?? this.note,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SessionDetails.fromJson(Map<String, dynamic> json) => SessionDetails(
    id: json["id"],
    user: User.fromJson(json["user"]),
    therapist: DataTherapist.fromJson(json["therapist"]),
    reference: json["reference"],
    focus:  json["focus"]==null?[]:List<String>.from(json["focus"].map((x) => x)) ,

    duration: json["duration"],
    startsAt: json["starts_at"],
    endsAt: json["ends_at"],
    note: json["note"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "therapist": therapist.toJson(),
    "reference": reference,
    "focus": focus,
    "duration": duration,
    "starts_at": startsAt,
    "ends_at": endsAt,
    "note": note,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class DataTherapist {
  final User user;
  final Therapist therapist;

  DataTherapist({
    required this.user,
    required this.therapist,
  });

  DataTherapist copyWith({
    User? user,
    Therapist? therapist,
  }) =>
      DataTherapist(
        user: user ?? this.user,
        therapist: therapist ?? this.therapist,
      );

  factory DataTherapist.fromJson(Map<String, dynamic> json) => DataTherapist(
    user: User.fromJson(json["user"]),
    therapist: Therapist.fromJson(json["therapist"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "therapist": therapist.toJson(),
  };
}



class User {
  final int id;
  final String avatar;
  final String name;
  final String role;
  final dynamic avatarBackgroundColor;
  final String username;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.avatar,
    required this.name,
    required this.role,
    required this.avatarBackgroundColor,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    dynamic avatarBackgroundColor,
    String? username,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor: avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    role: json["role"],
    avatarBackgroundColor: json["avatar_background_color"],
    username: json["username"],
    email: json["email"],
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}