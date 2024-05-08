import 'dart:convert';

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

class Caller {
  final String role;
  final String? avatarBackgroundColor;
  final String name;
  final String avatar;
  final String email;

  Caller({
    required this.role,
    this.avatarBackgroundColor,
    required this.name,
    required this.avatar,
    required this.email,
  });

  factory Caller.fromJson(Map<String, dynamic> json) {
    return Caller(
      role: json['role'] as String,
      avatarBackgroundColor: json['avatar_background_color'] as String?,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'role': role,
        'avatar_background_color': avatarBackgroundColor,
        'name': name,
        'avatar': avatar,
        'email': email,
      };
}
