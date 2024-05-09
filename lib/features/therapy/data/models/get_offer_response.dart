// To parse this JSON data, do
//
//     final getOfferResponse = getOfferResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/therapy/data/models/incoming_response.dart';

GetOfferResponse getOfferResponseFromJson(String str) => GetOfferResponse.fromJson(json.decode(str));

String getOfferResponseToJson(GetOfferResponse data) => json.encode(data.toJson());

class GetOfferResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  GetOfferResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetOfferResponse.fromJson(Map<String, dynamic> json) => GetOfferResponse(
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
  final int id;
  final Payload payload;
  final DateTime createdAt;

  Data({
    required this.id,
    required this.payload,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    payload: Payload.fromJson(json["payload"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payload": payload.toJson(),
    "created_at": createdAt.toIso8601String(),
  };
}

class Payload {
  final int calleeId;
  final int callerId;
  final SdpOffer sdpOffer;

  Payload({
    required this.calleeId,
    required this.callerId,
    required this.sdpOffer,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    calleeId: json["calleeId"],
    callerId: json["callerId"],
    sdpOffer: SdpOffer.fromJson(
      jsonDecode(
        utf8.decode(
          base64.decode(
            json["sdpOffer"],
          ),
        ),
      ),
    ),
  );

  Map<String, dynamic> toJson() => {
    "calleeId": calleeId,
    "callerId": callerId,
    "sdpOffer": sdpOffer.toJson(),
  };
}
