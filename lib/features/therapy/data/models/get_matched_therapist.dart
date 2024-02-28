// To parse this JSON data, do
//
//     final getMatchedTherapist = getMatchedTherapistFromJson(jsonString);

import 'dart:convert';

GetMatchedTherapistResponse getMatchedTherapistFromJson(String str) => GetMatchedTherapistResponse.fromJson(json.decode(str));

String getMatchedTherapistToJson(GetMatchedTherapistResponse data) => json.encode(data.toJson());

class GetMatchedTherapistResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  GetMatchedTherapistResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetMatchedTherapistResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      GetMatchedTherapistResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetMatchedTherapistResponse.fromJson(Map<String, dynamic> json) => GetMatchedTherapistResponse(
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
  final User user;
  final Therapist therapist;

  Data({
    required this.user,
    required this.therapist,
  });

  Data copyWith({
    User? user,
    Therapist? therapist,
  }) =>
      Data(
        user: user ?? this.user,
        therapist: therapist ?? this.therapist,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
  final String nationality;
  final String country;
  final String address;
  final dynamic bio;
  final dynamic field;
  final dynamic yearsOfExperience;
  final String emirateOfLicensure;
  final dynamic currentWorkplace;
  final dynamic weeklyTimeSpent;
  final dynamic interestInMentra;
  final dynamic intendedWeeklyTime;
  final dynamic heardAboutUs;
  final dynamic treatableConditions;
  final dynamic techniquesOfExpertise;
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
    required this.field,
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
    dynamic field,
    dynamic yearsOfExperience,
    String? emirateOfLicensure,
    dynamic currentWorkplace,
    dynamic weeklyTimeSpent,
    dynamic interestInMentra,
    dynamic intendedWeeklyTime,
    dynamic heardAboutUs,
    dynamic treatableConditions,
    dynamic techniquesOfExpertise,
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
        techniquesOfExpertise: techniquesOfExpertise ?? this.techniquesOfExpertise,
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
    countriesLivedIn: List<String>.from(json["countries_lived_in"].map((x) => x)),
    languagesSpoken: List<String>.from(json["languages_spoken"].map((x) => x)),
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
    treatableConditions: json["treatable_conditions"],
    techniquesOfExpertise: json["techniques_of_expertise"],
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
    "countries_lived_in": List<dynamic>.from(countriesLivedIn.map((x) => x)),
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
    "treatable_conditions": treatableConditions,
    "techniques_of_expertise": techniquesOfExpertise,
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
  final String avatarBackgroundColor;
  final String username;
  final String email;
  final String stripeCustomerId;
  final String mesiboUserId;
  final String mesiboUserToken;
  final dynamic activeSubscription;
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
    required this.stripeCustomerId,
    required this.mesiboUserId,
    required this.mesiboUserToken,
    required this.activeSubscription,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    String? avatarBackgroundColor,
    String? username,
    String? email,
    String? stripeCustomerId,
    String? mesiboUserId,
    String? mesiboUserToken,
    dynamic activeSubscription,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor: avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        mesiboUserId: mesiboUserId ?? this.mesiboUserId,
        mesiboUserToken: mesiboUserToken ?? this.mesiboUserToken,
        activeSubscription: activeSubscription ?? this.activeSubscription,
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
    stripeCustomerId: json["stripe_customer_id"],
    mesiboUserId: json["mesibo_user_id"],
    mesiboUserToken: json["mesibo_user_token"],
    activeSubscription: json["active_subscription"],
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
    "stripe_customer_id": stripeCustomerId,
    "mesibo_user_id": mesiboUserId,
    "mesibo_user_token": mesiboUserToken,
    "active_subscription": activeSubscription,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
