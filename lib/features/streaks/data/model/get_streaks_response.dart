// To parse this JSON data, do
//
//     final getStreaksResponse = getStreaksResponseFromJson(jsonString);

import 'dart:convert';

GetStreaksResponse getStreaksResponseFromJson(String str) =>
    GetStreaksResponse.fromJson(json.decode(str));

String getStreaksResponseToJson(GetStreaksResponse data) =>
    json.encode(data.toJson());

class GetStreaksResponse {
  final String message;
  final List<BadgeModel> data;
  final bool success;
  final int code;

  GetStreaksResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetStreaksResponse.fromJson(Map<String, dynamic> json) =>
      GetStreaksResponse(
        message: json["message"],
        data: List<BadgeModel>.from(
            json["data"].map((x) => BadgeModel.fromJson(x))),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "code": code,
      };

  bool shouldFadeOut(BadgeModel currentStreak) {
    var usersStreak =
        data.where((element) => element.isCurrentBadge).firstOrNull;

    if (usersStreak != null) {
      return currentStreak.duration > usersStreak.duration;
    } else {
      return true;
    }
  }
}

class BadgeModel {
  final int id;
  final String name;
  final dynamic description;
  final dynamic frequency;
  final dynamic duration;
  final dynamic status;
  final dynamic isCurrentBadge;
  final Image image;
  final DateTime createdAt;
  final DateTime updatedAt;

  BadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.frequency,
    required this.duration,
    required this.status,
    required this.isCurrentBadge,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        frequency: json["frequency"],
        duration: json["duration"],
        status: json["status"],
        isCurrentBadge: json["is_current_badge"],
        image: Image.fromJson(json["image"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "frequency": frequency,
        "duration": duration,
        "status": status,
        "is_current_badge": isCurrentBadge,
        "image": image.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Image {
  final int id;
  final dynamic name;
  final String url;
  final String mimeType;
  final String size;
  final String formattedSize;
  final DateTime createdAt;

  Image({
    required this.id,
    required this.name,
    required this.url,
    required this.mimeType,
    required this.size,
    required this.formattedSize,
    required this.createdAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        mimeType: json["mime_type"],
        size: json["size"],
        formattedSize: json["formatted_size"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "mime_type": mimeType,
        "size": size,
        "formatted_size": formattedSize,
        "created_at": createdAt.toIso8601String(),
      };
}
