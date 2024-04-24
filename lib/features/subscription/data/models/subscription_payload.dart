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
  final String cardToken;
  final String amount;
  final String planName;

  SubscriptionPayload({
    required this.planId,
    required this.planDurationId,
    required this.cardToken,
    required this.amount,
    required this.planName,
  });

  // SubscriptionPayload copyWith({
  //   int? planId,
  //   int? planDurationId,
  //   String? cardOwnerName,
  //   String? cardNumber,
  //   int? cardExpMonth,
  //   int? cardExpYear,
  //   int? cardCvc,
  // }) =>
  //     SubscriptionPayload(
  //       planId: planId ?? this.planId,
  //       planDurationId: planDurationId ?? this.planDurationId,
  //       cardOwnerName: cardOwnerName ?? this.cardOwnerName,
  //       cardNumber: cardNumber ?? this.cardNumber,
  //       cardExpMonth: cardExpMonth ?? this.cardExpMonth,
  //       cardExpYear: cardExpYear ?? this.cardExpYear,
  //       cardCvc: cardCvc ?? this.cardCvc,
  //     );

  factory SubscriptionPayload.fromJson(Map<String, dynamic> json) =>
      SubscriptionPayload(
        planId: json["plan_id"],
        planDurationId: json["plan_duration_id"],
        cardToken: json["card_token"],
        planName: json["planName"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "plan_duration_id": planDurationId,
        "card_token": cardToken,
      };
}
