// To parse this JSON data, do
//
//     final registrationPayload = registrationPayloadFromJson(jsonString);

import 'dart:convert';

RegistrationPayload registrationPayloadFromJson(String str) =>
    RegistrationPayload.fromJson(json.decode(str));

String registrationPayloadToJson(RegistrationPayload data) =>
    json.encode(data.toJson());

class RegistrationPayload {
  final String name;
  final String email;
  final String birthYear;
  final String password;
  final String avatar;
  final String role;

  RegistrationPayload({
    required this.name,
    required this.email,
    required this.birthYear,
    required this.password,
    required this.avatar,
    required this.role,
  });

  RegistrationPayload copyWith({
    String? name,
    String? email,
    String? birthYear,
    String? password,
    String? avatar,
    String? role,
  }) =>
      RegistrationPayload(
        name: name ?? this.name,
        email: email ?? this.email,
        birthYear: birthYear ?? this.birthYear,
        password: password ?? this.password,
        avatar: avatar ?? this.avatar,
        role: role ?? this.role,
      );

  factory RegistrationPayload.fromJson(Map<String, dynamic> json) =>
      RegistrationPayload(
        name: json["name"],
        email: json["email"],
        birthYear: json["birth_year"],
        password: json["password"],
        avatar: json["avatar_id"],
        role: json["role"],
      );

  factory RegistrationPayload.empty() => RegistrationPayload(
      name: '', email: '', birthYear: '', password: '', avatar: '', role: '');

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "birth_year": birthYear,
        "password": password,
        "avatar_id": avatar,
        "role": role,
      };
}
