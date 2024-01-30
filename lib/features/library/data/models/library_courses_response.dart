// To parse this JSON data, do
//
//     final getLibraryCoursesResponse = getLibraryCoursesResponseFromJson(jsonString);

import 'dart:convert';

GetLibraryCoursesResponse getLibraryCoursesResponseFromJson(String str) => GetLibraryCoursesResponse.fromJson(json.decode(str));

String getLibraryCoursesResponseToJson(GetLibraryCoursesResponse data) => json.encode(data.toJson());

class GetLibraryCoursesResponse {
  final String message;
  final List<LibraryCourse> data;
  final bool success;
  final int code;

  GetLibraryCoursesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetLibraryCoursesResponse copyWith({
    String? message,
    List<LibraryCourse>? data,
    bool? success,
    int? code,
  }) =>
      GetLibraryCoursesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetLibraryCoursesResponse.fromJson(Map<String, dynamic> json) => GetLibraryCoursesResponse(
    message: json["message"],
    data: List<LibraryCourse>.from(json["data"].map((x) => LibraryCourse.fromJson(x))),
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

// To parse this JSON data, do
//
//     final libraryCourse = libraryCourseFromJson(jsonString);



LibraryCourse libraryCourseFromJson(String str) => LibraryCourse.fromJson(json.decode(str));

String libraryCourseToJson(LibraryCourse data) => json.encode(data.toJson());

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

class LibraryCourse {
  final int id;
  final String title;
  final String body;
  final String courseType;
  final String status;
  final Category? category;
  final List<Attachment>? attachments;
  final bool favourite;
  final DateTime createdAt;
  final DateTime updatedAt;

  LibraryCourse({
    required this.id,
    required this.title,
    required this.body,
    required this.courseType,
    required this.status,
    this.category,
    this.attachments,
    required this.favourite,
    required this.createdAt,
    required this.updatedAt,
  });

  LibraryCourse copyWith({
    int? id,
    String? title,
    String? body,
    String? courseType,
    String? status,
    Category? category,
    List<Attachment>? attachments,
    bool? favourite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      LibraryCourse(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        courseType: courseType ?? this.courseType,
        status: status ?? this.status,
        category: category ?? this.category,
        attachments: attachments ?? this.attachments,
        favourite: favourite ?? this.favourite,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory LibraryCourse.fromJson(Map<String, dynamic> json) => LibraryCourse(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    courseType: json["course_type"],
    status: json["status"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    favourite: json["favourite"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "course_type": courseType,
    "status": status,
    "category": category?.toJson(),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "favourite": favourite,
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

class Category {
  final int id;
  final String name;
  final String description;
  final String backgroundColor;
  final String status;
  final Image image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.backgroundColor,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? name,
    String? description,
    String? backgroundColor,
    String? status,
    Image? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        status: status ?? this.status,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    backgroundColor: json["background_color"],
    status: json["status"],
    image: Image.fromJson(json["image"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "background_color": backgroundColor,
    "status": status,
    "image": image.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}














