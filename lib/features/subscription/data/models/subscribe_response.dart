// To parse this JSON data, do
//
//     final subscribeResponse = subscribeResponseFromJson(jsonString);

import 'dart:convert';

SubscribeResponse subscribeResponseFromJson(String str) =>
    SubscribeResponse.fromJson(json.decode(str));

String subscribeResponseToJson(SubscribeResponse data) =>
    json.encode(data.toJson());

class SubscribeResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  SubscribeResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  SubscribeResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      SubscribeResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory SubscribeResponse.fromJson(Map<String, dynamic> json) =>
      SubscribeResponse(
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
  final int id;
  final User user;
  final Plan plan;
  final dynamic stripeSubscriptionId;
  final dynamic stripeClientSecret;
  final dynamic status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.user,
    required this.plan,
    required this.stripeSubscriptionId,
    required this.stripeClientSecret,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    User? user,
    Plan? plan,
    String? stripeSubscriptionId,
    dynamic stripeClientSecret,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        user: user ?? this.user,
        plan: plan ?? this.plan,
        stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
        stripeClientSecret: stripeClientSecret ?? this.stripeClientSecret,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        user: User.fromJson(json["user"]),
        plan: Plan.fromJson(json["plan"]),
        stripeSubscriptionId: json["stripe_subscription_id"],
        stripeClientSecret: json["stripe_client_secret"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "plan": plan.toJson(),
        "stripe_subscription_id": stripeSubscriptionId,
        "stripe_client_secret": stripeClientSecret,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Plan {
  final dynamic id;
  final dynamic name;
  final dynamic description;
  final dynamic frequency;
  final dynamic price;
  final dynamic discount;
  final dynamic status;
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
        "durations": List<dynamic>.from(durations.map((x) => x.toJson())),
        "benefits": List<dynamic>.from(benefits.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Benefit {
  final dynamic id;
  final dynamic title;
  final dynamic key;
  final dynamic createdAt;
  final dynamic updatedAt;

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
    this.stripePriceId,
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

class User {
  final int id;
  final String avatar;
  final String name;
  final String role;
  final dynamic avatarBackgroundColor;
  final String username;
  final String email;
  final String birthYear;
  final String stripeCustomerId;
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
    required this.birthYear,
    required this.stripeCustomerId,
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
    String? birthYear,
    String? stripeCustomerId,
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
        birthYear: birthYear ?? this.birthYear,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
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
        birthYear: json["birth_year"],
        stripeCustomerId: json["stripe_customer_id"],
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
