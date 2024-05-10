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
  final int calleeId;
  final int callerId;
  final SdpOffer sdpOffer;
  final Caller therapist;
  final int therapySessionId;
  final int id;

  Data({
    required this.calleeId,
    required this.callerId,
    required this.sdpOffer,
    required this.therapist,
    required this.therapySessionId,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    therapist: Caller.fromJson(json["therapist"]),
    therapySessionId: json["therapy_session_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "calleeId": calleeId,
    "callerId": callerId,
    "sdpOffer": sdpOffer.toJson(),
    "therapist": therapist.toJson(),
    "therapy_session_id": therapySessionId,
    "id": id,
  };
}



