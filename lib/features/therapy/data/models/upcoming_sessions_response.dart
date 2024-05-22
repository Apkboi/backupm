// To parse this JSON data, do
//
//     final upcomingSessionsResponse = upcomingSessionsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';

import 'chat_therapist.dart';

UpcomingSessionsResponse upcomingSessionsResponseFromJson(String str) =>
    UpcomingSessionsResponse.fromJson(json.decode(str));

String upcomingSessionsResponseToJson(UpcomingSessionsResponse data) =>
    json.encode(data.toJson());

class UpcomingSessionsResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  UpcomingSessionsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UpcomingSessionsResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      UpcomingSessionsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UpcomingSessionsResponse.fromJson(Map<String, dynamic> json) =>
      UpcomingSessionsResponse(
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
  final PaginationMeta paginationMeta;
  final List<TherapySession> data;

  Data({
    required this.paginationMeta,
    required this.data,
  });

  Data copyWith({
    PaginationMeta? paginationMeta,
    List<TherapySession>? data,
  }) =>
      Data(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paginationMeta: PaginationMeta.fromJson(json["pagination_meta"]),
        data: List<TherapySession>.from(
            json["data"].map((x) => TherapySession.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination_meta": paginationMeta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TherapySession {
  final int id;
  final User user;
  final SessionTherapist therapist;
  final String reference;
  final List<String> focus;
  final int duration;
  final DateTime startsAt;
  final dynamic endsAt;
  final dynamic note;
  final String status;
  final dynamic mesiboGroupId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TherapySession({
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
    required this.mesiboGroupId,
    required this.createdAt,
    required this.updatedAt,
  });

  TherapySession copyWith({
    int? id,
    User? user,
    SessionTherapist? therapist,
    String? reference,
    List<String>? focus,
    int? duration,
    DateTime? startsAt,
    dynamic endsAt,
    dynamic note,
    String? status,
    dynamic mesiboGroupId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TherapySession(
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
        mesiboGroupId: mesiboGroupId ?? this.mesiboGroupId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TherapySession.fromJson(Map<String, dynamic> json) => TherapySession(
        id: json["id"],
        user: User.fromJson(json["user"]),
        therapist: SessionTherapist.fromJson(json["therapist"]),
        reference: json["reference"],
        focus: json["focus"] is List
            ? json["focus"] == null
                ? []
                : List<String>.from(json["focus"].map((x) => x))
            : [json["focus"] ?? ''],
        duration: json["duration"],
        startsAt: DateTime.parse(json["starts_at"]),
        endsAt:
            json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
        note: json["note"],
        status: json["status"],
        mesiboGroupId: json["mesibo_group_id"],
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
        "starts_at": startsAt.toIso8601String(),
        "ends_at": endsAt.toIso8601String(),
        "note": note,
        "status": status,
        "mesibo_group_id": mesiboGroupId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SessionTherapist {
  final User user;
  final Therapist therapist;

  SessionTherapist({
    required this.user,
    required this.therapist,
  });

  SessionTherapist copyWith({
    User? user,
    Therapist? therapist,
  }) =>
      SessionTherapist(
        user: user ?? this.user,
        therapist: therapist ?? this.therapist,
      );

  factory SessionTherapist.fromJson(Map<String, dynamic> json) =>
      SessionTherapist(
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
  final String stripeCustomerId;
  final String mesiboUserId;
  final String mesiboUserToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? birthYear;

  User({
    required this.id,
    required this.avatar,
    required this.name,
    required this.role,
    required this.avatarBackgroundColor,
    required this.username,
    required this.email,
    required this.stripeCustomerId,
    required this.mesiboUserId,
    required this.mesiboUserToken,
    required this.createdAt,
    required this.updatedAt,
    this.birthYear,
  });

  User copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    dynamic avatarBackgroundColor,
    String? username,
    String? email,
    String? stripeCustomerId,
    String? mesiboUserId,
    String? mesiboUserToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? birthYear,
  }) =>
      User(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor:
            avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        mesiboUserId: mesiboUserId ?? this.mesiboUserId,
        mesiboUserToken: mesiboUserToken ?? this.mesiboUserToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        birthYear: birthYear ?? this.birthYear,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        role: json["role"],
        avatarBackgroundColor: json["avatar_background_color"],
        username: json["username"],
        email: json["email"],
        stripeCustomerId: json["stripe_customer_id"],
        mesiboUserId: json["mesibo_user_id"],
        mesiboUserToken: json["mesibo_user_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        birthYear: json["birth_year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "role": role,
        "avatar_background_color": avatarBackgroundColor,
        "username": username,
        "email": email,
        "stripe_customer_id": stripeCustomerId,
        "mesibo_user_id": mesiboUserId,
        "mesibo_user_token": mesiboUserToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "birth_year": birthYear,
      };
}

class PaginationMeta {
  final int currentPage;
  final String firstPageUrl;
  final dynamic from;
  final int lastPage;
  final String lastPageUrl;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final dynamic to;
  final int total;
  final bool canLoadMore;

  PaginationMeta({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.canLoadMore,
  });

  PaginationMeta copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
    bool? canLoadMore,
  }) =>
      PaginationMeta(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
        currentPage: json["current_page"],
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
        canLoadMore: json["can_load_more"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
        "can_load_more": canLoadMore,
      };
}

ChatTherapist mapToChatTherapist(SessionTherapist sessionTherapist) {
  logger.w(sessionTherapist.user.id);
  return ChatTherapist(
    avatarId: sessionTherapist.user.avatar,
    // Assuming therapist avatar maps to avatarId
    fullName: sessionTherapist.user.name,
    // Assuming therapist name maps to fullName
    createdAt: sessionTherapist.user.createdAt,
    // Both classes have the same field
    phoneNumber: "",
    // Therapist phone number might not be available in SessionTherapist, provide a default value
    id: sessionTherapist.user.id,
    // Assuming therapist id maps to id
    title: sessionTherapist.therapist.field
        .toString(),
    userId: sessionTherapist.user.id,// Assuming therapist title maps to title
  );
}
