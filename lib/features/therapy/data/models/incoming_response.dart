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
  final Caller therapist;

  IncomingCallResponse({
    required this.callerId,
    required this.sdpOffer,
    required this.sdpAnswer,
    required this.therapist,
  });

  // factory IncomingCallResponse.fromJson(Map<String, dynamic> json) => IncomingCallResponse(
  //   callerId: json["callerId"],
  //   sdpOffer: SdpOffer.fromJson(jsonDecode(utf8.decode(base64.decode(json["sdpOffer"])))),
  // );

  factory IncomingCallResponse.fromJson(Map<String, dynamic> json) {
    return IncomingCallResponse(
      callerId: json["callerId"],
      sdpOffer: json["sdpOffer"] != null
          ? SdpOffer.fromJson(
              jsonDecode(
                utf8.decode(
                  base64.decode(
                    json["sdpOffer"],
                  ),
                ),
              ),
            )
          : null,
      sdpAnswer: json["sdpAnswer"] != null
          ? SdpAnswer.fromJson(
              jsonDecode(
                utf8.decode(
                  base64.decode(
                    json["sdpAnswer"],
                  ),
                ),
              ),
            )
          : null,
      therapist: Caller.fromJson(json["therapist"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "callerId": callerId,
        "sdpOffer": sdpOffer?.toJson(),
        "sdpAnswer": sdpAnswer?.toJson(),
        "therapist": therapist.toJson(),
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

class Caller {
  final String avatar;
  final String name;
  final String role;
  final String email;

  Caller({
    required this.avatar,
    required this.name,
    required this.role,
    required this.email,
  });

  factory Caller.fromJson(Map<String, dynamic> json) => Caller(
        avatar: json["avatar"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "name": name,
        "role": role,
        "email": email,
      };
}
