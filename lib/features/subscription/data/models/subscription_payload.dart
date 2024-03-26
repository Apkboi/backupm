// To parse this JSON data, do
//
//     final subscribtionPayload = subscribtionPayloadFromJson(jsonString);

import 'dart:convert';

SubscriptionPayload subscribtionPayloadFromJson(String str) =>
    SubscriptionPayload.fromJson(json.decode(str));

String subscribtionPayloadToJson(SubscriptionPayload data) =>
    json.encode(data.toJson());

class SubscriptionPayload {
  final int planId;
  final int planDurationId;
  final String cardOwnerName;
  final String cardNumber;
  final int cardExpMonth;
  final int cardExpYear;
  final int cardCvc;

  SubscriptionPayload({
    required this.planId,
    required this.planDurationId,
    required this.cardOwnerName,
    required this.cardNumber,
    required this.cardExpMonth,
    required this.cardExpYear,
    required this.cardCvc,
  });

  SubscriptionPayload copyWith({
    int? planId,
    int? planDurationId,
    String? cardOwnerName,
    String? cardNumber,
    int? cardExpMonth,
    int? cardExpYear,
    int? cardCvc,
  }) =>
      SubscriptionPayload(
        planId: planId ?? this.planId,
        planDurationId: planDurationId ?? this.planDurationId,
        cardOwnerName: cardOwnerName ?? this.cardOwnerName,
        cardNumber: cardNumber ?? this.cardNumber,
        cardExpMonth: cardExpMonth ?? this.cardExpMonth,
        cardExpYear: cardExpYear ?? this.cardExpYear,
        cardCvc: cardCvc ?? this.cardCvc,
      );

  factory SubscriptionPayload.fromJson(Map<String, dynamic> json) =>
      SubscriptionPayload(
        planId: json["plan_id"],
        planDurationId: json["plan_duration_id"],
        cardOwnerName: json["card_owner_name"],
        cardNumber: json["card_number"],
        cardExpMonth: json["card_exp_month"],
        cardExpYear: json["card_exp_year"],
        cardCvc: json["card_cvc"],
      );

  Map<String, dynamic> toJson() =>
      {
        "plan_id": planId,
        "plan_duration_id": planDurationId,
        "card_owner_name": cardOwnerName,
        "card_number": cardNumber,
        "card_exp_month": cardExpMonth,
        "card_exp_year": cardExpYear,
        "card_cvc": cardCvc,
      };
}
