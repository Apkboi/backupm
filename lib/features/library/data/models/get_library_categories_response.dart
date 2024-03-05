// To parse this JSON data, do
//
//     final getLibraryCategoriesResponse = getLibraryCategoriesResponseFromJson(jsonString);

import 'dart:convert';

GetLibraryCategoriesResponse getLibraryCategoriesResponseFromJson(String str) =>
    GetLibraryCategoriesResponse.fromJson(json.decode(str));

String getLibraryCategoriesResponseToJson(GetLibraryCategoriesResponse data) =>
    json.encode(data.toJson());

class GetLibraryCategoriesResponse {
  final String message;
  final List<LibraryCategory> data;
  final bool success;
  final int code;

  GetLibraryCategoriesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetLibraryCategoriesResponse copyWith({
    String? message,
    List<LibraryCategory>? data,
    bool? success,
    int? code,
  }) =>
      GetLibraryCategoriesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetLibraryCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      GetLibraryCategoriesResponse(
        message: json["message"],
        data: List<LibraryCategory>.from(json["data"].map((x) => LibraryCategory.fromJson(x))),
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

class LibraryCategory {
  final int id;
  final dynamic name;
  final dynamic description;
  final dynamic backgroundColor;
  final dynamic status;
  final Image? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  LibraryCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.backgroundColor,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  LibraryCategory copyWith({
    int? id,
    String? name,
    String? description,
    String? backgroundColor,
    String? status,
    Image? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      LibraryCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        status: status ?? this.status,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory LibraryCategory.fromJson(Map<String, dynamic> json) => LibraryCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        backgroundColor: json["background_color"],
        status: json["status"],
        image: json["image"]== null? null:Image.fromJson(json["image"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "background_color": backgroundColor,
        "status": status,
        "image": image?.toJson(),
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
