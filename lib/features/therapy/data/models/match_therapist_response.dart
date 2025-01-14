// To parse this JSON data, do
//
//     final matchTherapistResponse = matchTherapistResponseFromJson(jsonString);

import 'dart:convert';

MatchTherapistResponse matchTherapistResponseFromJson(String str) =>
    MatchTherapistResponse.fromJson(json.decode(str));

String matchTherapistResponseToJson(MatchTherapistResponse data) =>
    json.encode(data.toJson());

class MatchTherapistResponse {
  final String message;
  final SuggestedTherapist data;
  final bool success;
  final int code;

  MatchTherapistResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  MatchTherapistResponse copyWith({
    String? message,
    SuggestedTherapist? data,
    bool? success,
    int? code,
  }) =>
      MatchTherapistResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory MatchTherapistResponse.fromJson(Map<String, dynamic> json) =>
      MatchTherapistResponse(
        message: json["message"],
        data: SuggestedTherapist.fromJson(json["data"]),
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

class SuggestedTherapist {
  final User user;
  final Therapist therapist;

  SuggestedTherapist({
    required this.user,
    required this.therapist,
  });

  SuggestedTherapist copyWith({
    User? user,
    Therapist? therapist,
  }) =>
      SuggestedTherapist(
        user: user ?? this.user,
        therapist: therapist ?? this.therapist,
      );

  factory SuggestedTherapist.fromJson(Map<String, dynamic> json) =>
      SuggestedTherapist(
        user: User.fromJson(json["user"]),
        therapist: Therapist.fromJson(json["therapist"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "therapist": therapist.toJson(),
      };
}

class Therapist {
  final String phoneNumber;
  final dynamic phoneCode;
  final String gender;
  final List<String> countriesLivedIn;
  final List<String> languagesSpoken;
  final dynamic nationality;
  final dynamic country;
  final dynamic address;
  final dynamic bio;
  final dynamic field;
  final dynamic yearsOfExperience;
  final dynamic emirateOfLicensure;
  final dynamic currentWorkplace;
  final dynamic weeklyTimeSpent;
  final dynamic interestInMentra;
  final dynamic intendedWeeklyTime;
  final dynamic heardAboutUs;
  final List<String> treatableConditions;
  final List<String> techniquesOfExpertise;
  final dynamic certifications;
  final dynamic degrees;
  final dynamic comment;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Therapist({
    required this.phoneNumber,
    required this.phoneCode,
    required this.gender,
    required this.countriesLivedIn,
    required this.languagesSpoken,
    required this.nationality,
    required this.country,
    required this.address,
    required this.bio,
    this.field,
    required this.yearsOfExperience,
    required this.emirateOfLicensure,
    required this.currentWorkplace,
    required this.weeklyTimeSpent,
    required this.interestInMentra,
    required this.intendedWeeklyTime,
    required this.heardAboutUs,
    required this.treatableConditions,
    required this.techniquesOfExpertise,
    required this.certifications,
    required this.degrees,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Therapist copyWith({
    String? phoneNumber,
    dynamic phoneCode,
    String? gender,
    List<String>? countriesLivedIn,
    List<String>? languagesSpoken,
    String? nationality,
    String? country,
    String? address,
    dynamic bio,
    String? field,
    dynamic yearsOfExperience,
    String? emirateOfLicensure,
    String? currentWorkplace,
    String? weeklyTimeSpent,
    String? interestInMentra,
    String? intendedWeeklyTime,
    String? heardAboutUs,
    List<String>? treatableConditions,
    List<String>? techniquesOfExpertise,
    dynamic certifications,
    dynamic degrees,
    dynamic comment,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Therapist(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneCode: phoneCode ?? this.phoneCode,
        gender: gender ?? this.gender,
        countriesLivedIn: countriesLivedIn ?? this.countriesLivedIn,
        languagesSpoken: languagesSpoken ?? this.languagesSpoken,
        nationality: nationality ?? this.nationality,
        country: country ?? this.country,
        address: address ?? this.address,
        bio: bio ?? this.bio,
        field: field ?? this.field,
        yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
        emirateOfLicensure: emirateOfLicensure ?? this.emirateOfLicensure,
        currentWorkplace: currentWorkplace ?? this.currentWorkplace,
        weeklyTimeSpent: weeklyTimeSpent ?? this.weeklyTimeSpent,
        interestInMentra: interestInMentra ?? this.interestInMentra,
        intendedWeeklyTime: intendedWeeklyTime ?? this.intendedWeeklyTime,
        heardAboutUs: heardAboutUs ?? this.heardAboutUs,
        treatableConditions: treatableConditions ?? this.treatableConditions,
        techniquesOfExpertise:
            techniquesOfExpertise ?? this.techniquesOfExpertise,
        certifications: certifications ?? this.certifications,
        degrees: degrees ?? this.degrees,
        comment: comment ?? this.comment,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
        phoneNumber: json["phone_number"],
        phoneCode: json["phone_code"],
        gender: json["gender"],
        countriesLivedIn:
            List<String>.from(json["countries_lived_in"].map((x) => x)),
        languagesSpoken:
            List<String>.from(json["languages_spoken"].map((x) => x)),
        nationality: json["nationality"],
        country: json["country"],
        address: json["address"],
        bio: json["bio"],
        field: json["field"],
        yearsOfExperience: json["years_of_experience"],
        emirateOfLicensure: json["emirate_of_licensure"],
        currentWorkplace: json["current_workplace"],
        weeklyTimeSpent: json["weekly_time_spent"],
        interestInMentra: json["interest_in_mentra"],
        intendedWeeklyTime: json["intended_weekly_time"],
        heardAboutUs: json["heard_about_us"],
        treatableConditions: json["treatable_conditions"] == null
            ? []
            : List<String>.from(json["treatable_conditions"].map((x) => x)),
        techniquesOfExpertise: json["techniques_of_expertise"] == null
            ? []
            : List<String>.from(json["techniques_of_expertise"].map((x) => x)),
        certifications: json["certifications"],
        degrees: json["degrees"],
        comment: json["comment"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "phone_code": phoneCode,
        "gender": gender,
        "countries_lived_in":
            List<dynamic>.from(countriesLivedIn.map((x) => x)),
        "languages_spoken": List<dynamic>.from(languagesSpoken.map((x) => x)),
        "nationality": nationality,
        "country": country,
        "address": address,
        "bio": bio,
        "field": field,
        "years_of_experience": yearsOfExperience,
        "emirate_of_licensure": emirateOfLicensure,
        "current_workplace": currentWorkplace,
        "weekly_time_spent": weeklyTimeSpent,
        "interest_in_mentra": interestInMentra,
        "intended_weekly_time": intendedWeeklyTime,
        "heard_about_us": heardAboutUs,
        "treatable_conditions": treatableConditions == null
            ? []
            : List<dynamic>.from(treatableConditions.map((x) => x)),
        "techniques_of_expertise": techniquesOfExpertise == null
            ? []
            : List<dynamic>.from(techniquesOfExpertise.map((x) => x)),
        "certifications": certifications,
        "degrees": degrees,
        "comment": comment,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class User {
  final int id;
  final String avatar;
  final String name;
  final String role;
  final dynamic avatarBackgroundColor;
  final String username;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.avatar,
    required this.name,
    required this.role,
    required this.avatarBackgroundColor,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    dynamic avatarBackgroundColor,
    String? username,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor:
            avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        role: json["role"],
        avatarBackgroundColor: json["avatar_background_color"],
        username: json["username"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "role": role,
        "avatar_background_color": avatarBackgroundColor,
        "username": username,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
