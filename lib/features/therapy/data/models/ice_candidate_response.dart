// To parse this JSON data, do
//
//     final iceCandidateResponse = iceCandidateResponseFromJson(jsonString);
import 'dart:convert';

IceCandidateResponse iceCandidateResponseFromJson(String str) =>
    IceCandidateResponse.fromJson(json.decode(str));

String iceCandidateResponseToJson(IceCandidateResponse data) =>
    json.encode(data.toJson());

class IceCandidateResponse {
  final int callerId;
  final IceCandidate iceCandidate;

  IceCandidateResponse({
    required this.callerId,
    required this.iceCandidate,
  });

  factory IceCandidateResponse.fromJson(Map<String, dynamic> json) {
    return IceCandidateResponse(
        callerId: json["callerId"],
        iceCandidate: IceCandidate.fromJson(jsonDecode(
          utf8.decode(
            base64.decode(
              json["iceCandidate"],
            ),
          ),
        )));
  }

  Map<String, dynamic> toJson() => {
        "callerId": callerId,
        "iceCandidate": iceCandidate.toJson(),
      };
}

class IceCandidate {
  final String candidate;
  final String sdpMid;
  final int sdpMLineIndex;
  final String usernameFragment;

  IceCandidate({
    required this.candidate,
    required this.sdpMid,
    required this.sdpMLineIndex,
    required this.usernameFragment,
  });

  factory IceCandidate.fromJson(Map<String, dynamic> json) => IceCandidate(
        candidate: json["candidate"],
        sdpMid: json["sdpMid"],
        sdpMLineIndex: json["sdpMLineIndex"],
        usernameFragment: json["usernameFragment"],
      );

  Map<String, dynamic> toJson() => {
        "candidate": candidate,
        "sdpMid": sdpMid,
        "sdpMLineIndex": sdpMLineIndex,
        "usernameFragment": usernameFragment,
      };
}
