// To parse this JSON data, do
//
//     final updateFavouriteResponse = updateFavouriteResponseFromJson(jsonString);

import 'dart:convert';

UpdateFavouriteResponse updateFavouriteResponseFromJson(String str) => UpdateFavouriteResponse.fromJson(json.decode(str));

String updateFavouriteResponseToJson(UpdateFavouriteResponse data) => json.encode(data.toJson());

class UpdateFavouriteResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  UpdateFavouriteResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UpdateFavouriteResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      UpdateFavouriteResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UpdateFavouriteResponse.fromJson(Map<String, dynamic> json) => UpdateFavouriteResponse(
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
  final bool inFavourite;

  Data({
    required this.inFavourite,
  });

  Data copyWith({
    bool? inFavourite,
  }) =>
      Data(
        inFavourite: inFavourite ?? this.inFavourite,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    inFavourite: json["in_favourite"],
  );

  Map<String, dynamic> toJson() => {
    "in_favourite": inFavourite,
  };
}
