// To parse this JSON data, do
//
//     final getEmergencyContactsResponse = getEmergencyContactsResponseFromJson(jsonString);

import 'dart:convert';

GetEmergencyContactsResponse getEmergencyContactsResponseFromJson(String str) =>
    GetEmergencyContactsResponse.fromJson(json.decode(str));

String getEmergencyContactsResponseToJson(GetEmergencyContactsResponse data) =>
    json.encode(data.toJson());

class GetEmergencyContactsResponse {
  final String message;
  final List<EmergencyContact> data;
  final bool success;
  final int code;

  GetEmergencyContactsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetEmergencyContactsResponse copyWith({
    String? message,
    List<EmergencyContact>? data,
    bool? success,
    int? code,
  }) =>
      GetEmergencyContactsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetEmergencyContactsResponse.fromJson(Map<String, dynamic> json) =>
      GetEmergencyContactsResponse(
        message: json["message"],
        data: List<EmergencyContact>.from(json["data"].map((x) => EmergencyContact.fromJson(x))),
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

class EmergencyContact {
  final int id;
  final String title;
  final String description;
  final String contact;
  final String status;
  final Image image;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmergencyContact({
    required this.id,
    required this.title,
    required this.description,
    required this.contact,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  EmergencyContact copyWith({
    int? id,
    String? title,
    String? description,
    String? contact,
    String? status,
    Image? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      EmergencyContact(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        contact: contact ?? this.contact,
        status: status ?? this.status,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        contact: json["contact"],
        status: json["status"],
        image: Image.fromJson(json["image"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "contact": contact,
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
