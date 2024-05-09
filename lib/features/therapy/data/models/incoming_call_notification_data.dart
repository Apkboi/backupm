import 'dart:convert';

import 'package:mentra/features/therapy/data/models/incoming_response.dart';

class IncomingCallNotificationData {
  final String webrtcDescriptionId;
  final Caller therapist;

  IncomingCallNotificationData({
    required this.webrtcDescriptionId,
    required this.therapist,
  });

  factory IncomingCallNotificationData.fromJson(Map<String, dynamic> json) {
    return IncomingCallNotificationData(
      webrtcDescriptionId: json['webrtc_description_id'] as String,
      therapist: Caller.fromJson(jsonDecode(json['therapist'])),
    );
  }

  Map<String, dynamic> toJson() => {
        'webrtc_description_id': webrtcDescriptionId,
        'therapist': therapist.toJson(),
      };
}


