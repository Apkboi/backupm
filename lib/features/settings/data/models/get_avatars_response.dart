// To parse this JSON data, do
//
//     final getAvatarsResponse = getAvatarsResponseFromJson(jsonString);

import 'dart:convert';

GetAvatarsResponse getAvatarsResponseFromJson(String str) =>
    GetAvatarsResponse.fromJson(json.decode(str));

String getAvatarsResponseToJson(GetAvatarsResponse data) =>
    json.encode(data.toJson());

class GetAvatarsResponse {
  final String message;
  final List<AvatarImage> data;
  final bool success;
  final int code;

  GetAvatarsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetAvatarsResponse copyWith({
    String? message,
    List<AvatarImage>? data,
    bool? success,
    int? code,
  }) =>
      GetAvatarsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetAvatarsResponse.fromJson(Map<String, dynamic> json) =>
      GetAvatarsResponse(
        message: json["message"],
        data: List<AvatarImage>.from(
            json["data"].map((x) => AvatarImage.fromJson(x))),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "code": code,
      };
}

class AvatarImage {
  final int id;
  final dynamic title;
  final String description;
  final String status;
  final Image image;
  final DateTime createdAt;
  final DateTime updatedAt;

  AvatarImage({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  AvatarImage copyWith({
    int? id,
    dynamic title,
    String? description,
    String? status,
    Image? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AvatarImage(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AvatarImage.fromJson(Map<String, dynamic> json) => AvatarImage(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        image: Image.fromJson(json["image"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
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

  Image copyWith({
    int? id,
    dynamic name,
    String? url,
    String? mimeType,
    String? size,
    String? formattedSize,
    DateTime? createdAt,
  }) =>
      Image(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
        formattedSize: formattedSize ?? this.formattedSize,
        createdAt: createdAt ?? this.createdAt,
      );

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
