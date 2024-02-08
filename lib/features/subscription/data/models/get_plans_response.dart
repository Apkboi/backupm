// To parse this JSON data, do
//
//     final getPlansResponse = getPlansResponseFromJson(jsonString);

import 'dart:convert';

GetPlansResponse getPlansResponseFromJson(String str) =>
    GetPlansResponse.fromJson(json.decode(str));

String getPlansResponseToJson(GetPlansResponse data) =>
    json.encode(data.toJson());

class GetPlansResponse {
  final String message;
  final List<SubscriptionPlan> data;
  final bool success;
  final int code;

  GetPlansResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetPlansResponse copyWith({
    String? message,
    List<SubscriptionPlan>? data,
    bool? success,
    int? code,
  }) =>
      GetPlansResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetPlansResponse.fromJson(Map<String, dynamic> json) =>
      GetPlansResponse(
        message: json["message"],
        data: List<SubscriptionPlan>.from(
            json["data"].map((x) => SubscriptionPlan.fromJson(x))),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "code": code,
      };
}

class SubscriptionPlan {
  final int id;
  final String name;
  final bool isActiveSubscription;
  final String description;
  final String frequency;
  final int price;
  final int discount;
  final String status;
  final List<PlanDuration> durations;
  final List<Benefit> benefits;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.isActiveSubscription,
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

  SubscriptionPlan copyWith({
    int? id,
    String? name,
    String? description,
    String? frequency,
    bool? isActiveSubscription,
    int? price,
    int? discount,
    String? status,
    List<PlanDuration>? durations,
    List<Benefit>? benefits,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SubscriptionPlan(
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
        isActiveSubscription: isActiveSubscription ?? this.isActiveSubscription,
      );

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        frequency: json["frequency"],
        price: json["price"],
        discount: json["discount"],
        isActiveSubscription: json["is_active_subscription"],
        status: json["status"],
        durations: List<PlanDuration>.from(
            json["durations"].map((x) => PlanDuration.fromJson(x))),
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

class PlanDuration {
  final int id;
  final String frequency;
  final String duration;
  final int price;
  final int discount;
  final dynamic stripePriceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlanDuration({
    required this.id,
    required this.frequency,
    required this.duration,
    required this.price,
    required this.discount,
    required this.stripePriceId,
    required this.createdAt,
    required this.updatedAt,
  });

  PlanDuration copyWith({
    int? id,
    String? frequency,
    String? duration,
    int? price,
    int? discount,
    String? stripePriceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PlanDuration(
        id: id ?? this.id,
        frequency: frequency ?? this.frequency,
        duration: duration ?? this.duration,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        stripePriceId: stripePriceId ?? this.stripePriceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PlanDuration.fromJson(Map<String, dynamic> json) => PlanDuration(
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
