// To parse this JSON data, do
//
//     final incomingCallResponse = incomingCallResponseFromJson(jsonString);

import 'dart:convert';

IncomingCallResponse incomingCallResponseFromJson(String str) =>
    IncomingCallResponse.fromJson(json.decode(str));

String incomingCallResponseToJson(IncomingCallResponse data) =>
    json.encode(data.toJson());

class IncomingCallResponse {
  final dynamic callerId;
  final SdpOffer sdpOffer;

  IncomingCallResponse({
    required this.callerId,
    required this.sdpOffer,
  });

  // factory IncomingCallResponse.fromJson(Map<String, dynamic> json) => IncomingCallResponse(
  //   callerId: json["callerId"],
  //   sdpOffer: SdpOffer.fromJson(jsonDecode(utf8.decode(base64.decode(json["sdpOffer"])))),
  // );

  factory IncomingCallResponse.fromJson(Map<String, dynamic> json) {
    return IncomingCallResponse(
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
  }

  Map<String, dynamic> toJson() => {
        "callerId": callerId,
        "sdpOffer": sdpOffer.toJson(),
      };
}

class SdpOffer {
  final dynamic type;
  final dynamic sdp;

  SdpOffer({
    required this.type,
    required this.sdp,
  });

  factory SdpOffer.fromJson(Map<String, dynamic> json) => SdpOffer(
        type: json["type"],
        sdp: json["sdp"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "sdp": sdp,
      };
}
