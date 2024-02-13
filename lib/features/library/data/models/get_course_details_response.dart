// To parse this JSON data, do
//
//     final getCourseDetailsResponse = getCourseDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/library/data/models/library_courses_response.dart';

GetCourseDetailsResponse getCourseDetailsResponseFromJson(String str) =>
    GetCourseDetailsResponse.fromJson(json.decode(str));

String getCourseDetailsResponseToJson(GetCourseDetailsResponse data) =>
    json.encode(data.toJson());

class GetCourseDetailsResponse {
  final String message;
  final LibraryCourse data;
  final bool success;
  final int code;

  GetCourseDetailsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetCourseDetailsResponse copyWith({
    String? message,
    LibraryCourse? data,
    bool? success,
    int? code,
  }) =>
      GetCourseDetailsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetCourseDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetCourseDetailsResponse(
        message: json["message"],
        data: LibraryCourse.fromJson(json["data"]),
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

class Attachment {
  final int id;
  final LibraryCourse course;
  final Image file;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attachment({
    required this.id,
    required this.course,
    required this.file,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Attachment copyWith({
    int? id,
    LibraryCourse? course,
    Image? file,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Attachment(
        id: id ?? this.id,
        course: course ?? this.course,
        file: file ?? this.file,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        course: LibraryCourse.fromJson(json["course"]),
        file: Image.fromJson(json["file"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course": course.toJson(),
        "file": file.toJson(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

