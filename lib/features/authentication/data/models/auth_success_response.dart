// To parse this JSON data, do
//
//     final authSuccessResponse = authSuccessResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mentra/features/streaks/data/model/get_streaks_response.dart';
import 'package:mentra/features/subscription/data/models/get_plans_response.dart';

AuthSuccessResponse authSuccessResponseFromJson(String str) =>
    AuthSuccessResponse.fromJson(json.decode(str));

String authSuccessResponseToJson(AuthSuccessResponse data) =>
    json.encode(data.toJson());

class AuthSuccessResponse {
  final String message;
  final AuthSuccessData data;
  final bool success;
  final int code;

  AuthSuccessResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  AuthSuccessResponse copyWith({
    String? message,
    AuthSuccessData? data,
    bool? success,
    int? code,
  }) =>
      AuthSuccessResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) =>
      AuthSuccessResponse(
        message: json["message"],
        data: AuthSuccessData.fromJson(json["data"]),
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

class AuthSuccessData {
  final String token;
  final MentraUser user;

  AuthSuccessData({
    required this.token,
    required this.user,
  });

  AuthSuccessData copyWith({
    String? token,
    MentraUser? user,
  }) =>
      AuthSuccessData(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory AuthSuccessData.fromJson(Map<String, dynamic> json) =>
      AuthSuccessData(
        token: json["token"],
        user: MentraUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class ActiveSubscription {
  final int id;
  final SubscriptionPlan plan;
  final dynamic stripeSubscriptionId;
  final dynamic stripeClientSecret;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ActiveSubscription({
    required this.id,
    required this.plan,
    required this.stripeSubscriptionId,
    required this.stripeClientSecret,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  ActiveSubscription copyWith({
    int? id,
    SubscriptionPlan? plan,
    String? stripeSubscriptionId,
    dynamic stripeClientSecret,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ActiveSubscription(
        id: id ?? this.id,
        plan: plan ?? this.plan,
        stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
        stripeClientSecret: stripeClientSecret ?? this.stripeClientSecret,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) =>
      ActiveSubscription(
        id: json["id"],
        plan: SubscriptionPlan.fromJson(json["plan"]),
        stripeSubscriptionId: json["stripe_subscription_id"],
        stripeClientSecret: json["stripe_client_secret"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plan": plan.toJson(),
        "stripe_subscription_id": stripeSubscriptionId,
        "stripe_client_secret": stripeClientSecret,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

MentraUser mentraUserFromJson(String str) =>
    MentraUser.fromJson(json.decode(str));

String mentraUserToJson(MentraUser data) => json.encode(data.toJson());

class MentraUser {
  final int id;
  final String avatar;
  final String name;
  final String role;
  final dynamic avatarBackgroundColor;
  final String username;
  final String email;
  final dynamic birthYear;
  final dynamic stripeCustomerId;
  final dynamic mesiboUserId;
  final dynamic mesiboUserToken;
  final dynamic mood;
  final dynamic badgeUpdated;
  final dynamic streak;
  final BadgeModel? badge;
  final ActiveSubscription? activeSubscription;
  final MatchedTherapist? matchedTherapist;
  final List<String> featureCards;
  final DateTime createdAt;
  final DateTime updatedAt;

  MentraUser({
    required this.id,
    required this.avatar,
    required this.name,
    required this.mood,
    required this.role,
    required this.avatarBackgroundColor,
    required this.username,
    required this.email,
    required this.birthYear,
    required this.stripeCustomerId,
    required this.mesiboUserId,
    required this.mesiboUserToken,
    required this.activeSubscription,
    required this.matchedTherapist,
    required this.createdAt,
    required this.updatedAt,
    required this.streak,
    required this.badge,
    required this.featureCards,
    this.badgeUpdated,
  });

  MentraUser copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    String? mood,
    String? avatarBackgroundColor,
    String? username,
    String? email,
    String? birthYear,
    String? stripeCustomerId,
    String? mesiboUserId,
    String? mesiboUserToken,
    dynamic streak,
    BadgeModel? badge,
    ActiveSubscription? activeSubscription,
    MatchedTherapist? matchedTherapist,
    bool? badgeUpdated,
    DateTime? createdAt,
    DateTime? updatedAt,
     List<String>? featureCards

  }) =>
      MentraUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        mood: mood ?? this.mood,
        avatarBackgroundColor:
            avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        birthYear: birthYear ?? this.birthYear,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        mesiboUserId: mesiboUserId ?? this.mesiboUserId,
        mesiboUserToken: mesiboUserToken ?? this.mesiboUserToken,
        activeSubscription: activeSubscription ?? this.activeSubscription,
        matchedTherapist: matchedTherapist ?? this.matchedTherapist,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        badgeUpdated: badgeUpdated ?? this.badgeUpdated,
        badge: badge ?? this.badge,
        streak: streak ?? this.streak,
        featureCards:featureCards??this.featureCards,

      );

  factory MentraUser.fromJson(Map<String, dynamic> json) => MentraUser(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        role: json["role"],
        badgeUpdated: json["badge_updated"],
        avatarBackgroundColor: json["avatar_background_color"],
        username: json["username"],
        email: json["email"],
        birthYear: json["birth_year"],
        stripeCustomerId: json["stripe_customer_id"],
        mesiboUserId: json["mesibo_user_id"],
        mesiboUserToken: json["mesibo_user_token"],
        mood: json["mood"],
        streak: json["streaks"],
    featureCards:json["feature_cards"] == null? []:
    List<String>.from(json["feature_cards"].map((x) => x)),
        activeSubscription: json["active_subscription"] == null
            ? null
            : ActiveSubscription.fromJson(json["active_subscription"]),
        badge:
            json["badge"] == null ? null : BadgeModel.fromJson(json["badge"]),
        matchedTherapist: json["matched_therapist"] == null
            ? null
            : MatchedTherapist.fromJson(json["matched_therapist"]),
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
        "birth_year": birthYear,
        "stripe_customer_id": stripeCustomerId,
        "mesibo_user_id": mesiboUserId,
        "mesibo_user_token": mesiboUserToken,
        "mood": mood,
        "badge_updated": badgeUpdated,
        "active_subscription": activeSubscription?.toJson(),
        "feature_cards": List<dynamic>.from(featureCards.map((x) => x)),
        "matched_therapist": matchedTherapist?.toJson(),
        "streaks": streak,
        "badge": badge?.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class MatchedTherapist {
  final dynamic phoneNumber;
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

  MatchedTherapist({
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

  MatchedTherapist copyWith({
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
      MatchedTherapist(
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

  factory MatchedTherapist.fromJson(Map<String, dynamic> json) =>
      MatchedTherapist(
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
