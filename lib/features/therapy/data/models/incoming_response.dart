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
  final SdpOffer? sdpOffer;
  final SdpAnswer? sdpAnswer;

  IncomingCallResponse({
    required this.callerId,
    required this.sdpOffer,
    required this.sdpAnswer,
  });

  // factory IncomingCallResponse.fromJson(Map<String, dynamic> json) => IncomingCallResponse(
  //   callerId: json["callerId"],
  //   sdpOffer: SdpOffer.fromJson(jsonDecode(utf8.decode(base64.decode(json["sdpOffer"])))),
  // );

  factory IncomingCallResponse.fromJson(Map<String, dynamic> json) {
    return IncomingCallResponse(
      callerId: json["callerId"],
      sdpOffer: json["sdpOffer"] != null ? SdpOffer.fromJson(
        jsonDecode(
          utf8.decode(
            base64.decode(
              json["sdpOffer"],
            ),
          ),
        ),
      ) : null,
      sdpAnswer: json["sdpAnswer"] != null ? SdpAnswer.fromJson(
        jsonDecode(
          utf8.decode(
            base64.decode(
              json["sdpAnswer"],
            ),
          ),
        ),
      ) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "callerId": callerId,
        "sdpOffer": sdpOffer?.toJson(),
        "sdpAnswer": sdpAnswer?.toJson(),
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

class SdpAnswer {
  final dynamic type;
  final dynamic sdp;

  SdpAnswer({
    required this.type,
    required this.sdp,
  });

  factory SdpAnswer.fromJson(Map<String, dynamic> json) => SdpAnswer(
        type: json["type"],
        sdp: json["sdp"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "sdp": sdp,
      };
}
