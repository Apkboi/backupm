// To parse this JSON data, do
//
//     final newMeessageResponse = newMeessageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/therapy/data/models/send_message_response.dart';

NewMeessageResponse newMeessageResponseFromJson(String str) => NewMeessageResponse.fromJson(json.decode(str));

String newMeessageResponseToJson(NewMeessageResponse data) => json.encode(data.toJson());

class NewMeessageResponse {
  final ChatMessage data;

  NewMeessageResponse({
    required this.data,
  });

  factory NewMeessageResponse.fromJson(Map<String, dynamic> json) => NewMeessageResponse(
    data: ChatMessage.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}


