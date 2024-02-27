// To parse this JSON data, do
//
//     final authSuccessResponse = authSuccessResponseFromJson(jsonString);

import 'dart:convert';

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
  final Plan plan;
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
    Plan? plan,
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
        plan: Plan.fromJson(json["plan"]),
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

class Plan {
  final int id;
  final String name;
  final String description;
  final String frequency;
  final int price;
  final int discount;
  final String status;
  final bool isActiveSubscription;
  final List<Duration> durations;
  final List<Benefit> benefits;
  final DateTime createdAt;
  final DateTime updatedAt;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.frequency,
    required this.price,
    required this.discount,
    required this.status,
    required this.isActiveSubscription,
    required this.durations,
    required this.benefits,
    required this.createdAt,
    required this.updatedAt,
  });

  Plan copyWith({
    int? id,
    String? name,
    String? description,
    String? frequency,
    int? price,
    int? discount,
    String? status,
    bool? isActiveSubscription,
    List<Duration>? durations,
    List<Benefit>? benefits,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Plan(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        frequency: frequency ?? this.frequency,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        status: status ?? this.status,
        isActiveSubscription: isActiveSubscription ?? this.isActiveSubscription,
        durations: durations ?? this.durations,
        benefits: benefits ?? this.benefits,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        frequency: json["frequency"],
        price: json["price"],
        discount: json["discount"],
        status: json["status"],
        isActiveSubscription: json["is_active_subscription"],
        durations: List<Duration>.from(
            json["durations"].map((x) => Duration.fromJson(x))),
        benefits: List<Benefit>.from(
            json["benefits"].map((x) => Benefit.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "frequency": frequency,
        "price": price,
        "discount": discount,
        "status": status,
        "is_active_subscription": isActiveSubscription,
        "durations": List<dynamic>.from(durations.map((x) => x.toJson())),
        "benefits": List<dynamic>.from(benefits.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Benefit {
  final int id;
  final String title;
  final String key;
  final DateTime createdAt;
  final DateTime updatedAt;

  Benefit({
    required this.id,
    required this.title,
    required this.key,
    required this.createdAt,
    required this.updatedAt,
  });

  Benefit copyWith({
    int? id,
    String? title,
    String? key,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Benefit(
        id: id ?? this.id,
        title: title ?? this.title,
        key: key ?? this.key,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
        id: json["id"],
        title: json["title"],
        key: json["key"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "key": key,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Duration {
  final dynamic id;
  final dynamic frequency;
  final dynamic duration;
  final dynamic price;
  final dynamic discount;
  final dynamic stripePriceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Duration({
    required this.id,
    required this.frequency,
    required this.duration,
    required this.price,
    required this.discount,
    required this.stripePriceId,
    required this.createdAt,
    required this.updatedAt,
  });

  Duration copyWith({
    int? id,
    String? frequency,
    String? duration,
    int? price,
    int? discount,
    String? stripePriceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Duration(
        id: id ?? this.id,
        frequency: frequency ?? this.frequency,
        duration: duration ?? this.duration,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        stripePriceId: stripePriceId ?? this.stripePriceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        id: json["id"],
        frequency: json["frequency"],
        duration: json["duration"],
        price: json["price"],
        discount: json["discount"],
        stripePriceId: json["stripe_price_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "frequency": frequency,
        "duration": duration,
        "price": price,
        "discount": discount,
        "stripe_price_id": stripePriceId,
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
  final String birthYear;
  final dynamic stripeCustomerId;
  final dynamic mesiboUserId;
  final dynamic mesiboUserToken;
  final ActiveSubscription? activeSubscription;
  final MatchedTherapist? matchedTherapist;
  final DateTime createdAt;
  final DateTime updatedAt;

  MentraUser({
    required this.id,
    required this.avatar,
    required this.name,
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
  });

  MentraUser copyWith({
    int? id,
    String? avatar,
    String? name,
    String? role,
    String? avatarBackgroundColor,
    String? username,
    String? email,
    String? birthYear,
    String? stripeCustomerId,
    String? mesiboUserId,
    String? mesiboUserToken,
    ActiveSubscription? activeSubscription,
    MatchedTherapist? matchedTherapist,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      MentraUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
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
      );

  factory MentraUser.fromJson(Map<String, dynamic> json) => MentraUser(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        role: json["role"],
        avatarBackgroundColor: json["avatar_background_color"],
        username: json["username"],
        email: json["email"],
        birthYear: json["birth_year"],
        stripeCustomerId: json["stripe_customer_id"],
        mesiboUserId: json["mesibo_user_id"],
        mesiboUserToken: json["mesibo_user_token"],
        activeSubscription:
        json["active_subscription"] == null ? null:   ActiveSubscription.fromJson(json["active_subscription"]),
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
        "active_subscription": activeSubscription?.toJson(),
        "matched_therapist": matchedTherapist?.toJson(),
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
