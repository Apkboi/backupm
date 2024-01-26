// To parse this JSON data, do
//
//     final upcomingSessionsResponse = upcomingSessionsResponseFromJson(jsonString);

import 'dart:convert';

UpcomingSessionsResponse upcomingSessionsResponseFromJson(String str) => UpcomingSessionsResponse.fromJson(json.decode(str));

String upcomingSessionsResponseToJson(UpcomingSessionsResponse data) => json.encode(data.toJson());

class UpcomingSessionsResponse {
  final String message;
  final Data data;
  final bool success;
  final dynamic code;

  UpcomingSessionsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UpcomingSessionsResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      UpcomingSessionsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UpcomingSessionsResponse.fromJson(Map<String, dynamic> json) => UpcomingSessionsResponse(
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
  final PaginationMeta paginationMeta;
  final List<TherapySession> data;

  Data({
    required this.paginationMeta,
    required this.data,
  });

  Data copyWith({
    PaginationMeta? paginationMeta,
    List<TherapySession>? data,
  }) =>
      Data(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paginationMeta: PaginationMeta.fromJson(json["pagination_meta"]),
    data: List<TherapySession>.from(json["data"].map((x) => TherapySession.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination_meta": paginationMeta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TherapySession {
  final int id;
  final User user;
  final DatumTherapist therapist;
  final String reference;
  final String focus;
  final int duration;
  final DateTime startsAt;
  final dynamic endsAt;
  final dynamic note;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  TherapySession({
    required this.id,
    required this.user,
    required this.therapist,
    required this.reference,
    required this.focus,
    required this.duration,
    required this.startsAt,
    required this.endsAt,
    required this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  TherapySession copyWith({
    int? id,
    User? user,
    DatumTherapist? therapist,
    String? reference,
    String? focus,
    int? duration,
    DateTime? startsAt,
    dynamic endsAt,
    String? note,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TherapySession(
        id: id ?? this.id,
        user: user ?? this.user,
        therapist: therapist ?? this.therapist,
        reference: reference ?? this.reference,
        focus: focus ?? this.focus,
        duration: duration ?? this.duration,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        note: note ?? this.note,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TherapySession.fromJson(Map<String, dynamic> json) => TherapySession(
    id: json["id"],
    user: User.fromJson(json["user"]),
    therapist: DatumTherapist.fromJson(json["therapist"]),
    reference: json["reference"],
    focus: json["focus"],
    duration: json["duration"],
    startsAt: DateTime.parse(json["starts_at"]),
    endsAt: json["ends_at"],
    note: json["note"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "therapist": therapist.toJson(),
    "reference": reference,
    "focus": focus,
    "duration": duration,
    "starts_at": startsAt.toIso8601String(),
    "ends_at": endsAt,
    "note": note,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class DatumTherapist {
  final User user;
  final TherapistTherapist therapist;

  DatumTherapist({
    required this.user,
    required this.therapist,
  });

  DatumTherapist copyWith({
    User? user,
    TherapistTherapist? therapist,
  }) =>
      DatumTherapist(
        user: user ?? this.user,
        therapist: therapist ?? this.therapist,
      );

  factory DatumTherapist.fromJson(Map<String, dynamic> json) => DatumTherapist(
    user: User.fromJson(json["user"]),
    therapist: TherapistTherapist.fromJson(json["therapist"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "therapist": therapist.toJson(),
  };
}

class TherapistTherapist {
  final String phoneNumber;
  final dynamic phoneCode;
  final String gender;
  final List<String> countriesLivedIn;
  final List<String> languagesSpoken;
  final String nationality;
  final String country;
  final String address;
  final dynamic bio;
  final String field;
  final dynamic yearsOfExperience;
  final String emirateOfLicensure;
  final String currentWorkplace;
  final String weeklyTimeSpent;
  final String interestInMentra;
  final String intendedWeeklyTime;
  final String heardAboutUs;
  final List<String> treatableConditions;
  final List<String> techniquesOfExpertise;
  final dynamic certifications;
  final dynamic degrees;
  final dynamic comment;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  TherapistTherapist({
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

  TherapistTherapist copyWith({
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
      TherapistTherapist(
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

  factory TherapistTherapist.fromJson(Map<String, dynamic> json) => TherapistTherapist(
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
    treatableConditions: List<String>.from(json["treatable_conditions"].map((x) => x)),
    techniquesOfExpertise: List<String>.from(json["techniques_of_expertise"].map((x) => x)),
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
    "treatable_conditions": List<dynamic>.from(treatableConditions.map((x) => x)),
    "techniques_of_expertise": List<dynamic>.from(techniquesOfExpertise.map((x) => x)),
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
  final String? birthYear;

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
    this.birthYear,
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
    String? birthYear,
  }) =>
      User(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        role: role ?? this.role,
        avatarBackgroundColor: avatarBackgroundColor ?? this.avatarBackgroundColor,
        username: username ?? this.username,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        birthYear: birthYear ?? this.birthYear,
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
    birthYear: json["birth_year"],
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
    "birth_year": birthYear,
  };
}

class PaginationMeta {
  final dynamic currentPage;
  final String firstPageUrl;
  final dynamic from;
  final dynamic lastPage;
  final String lastPageUrl;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final dynamic to;
  final dynamic total;
  final bool canLoadMore;

  PaginationMeta({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.canLoadMore,
  });

  PaginationMeta copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
    bool? canLoadMore,
  }) =>
      PaginationMeta(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
    currentPage: json["current_page"],
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
    canLoadMore: json["can_load_more"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
    "can_load_more": canLoadMore,
  };
}
