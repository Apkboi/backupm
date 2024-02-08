// To parse this JSON data, do
//
//     final cardDetails = cardDetailsFromJson(jsonString);

import 'dart:convert';

SubscriptionCard cardDetailsFromJson(String str) => SubscriptionCard.fromJson(json.decode(str));

String cardDetailsToJson(SubscriptionCard data) => json.encode(data.toJson());

class SubscriptionCard {
  final String cardOwnerName;
  final String cardNumber;
  final int cardExpMonth;
  final int cardExpYear;
  final int cardCvc;

  SubscriptionCard({
    required this.cardOwnerName,
    required this.cardNumber,
    required this.cardExpMonth,
    required this.cardExpYear,
    required this.cardCvc,
  });

  SubscriptionCard copyWith({
    String? cardOwnerName,
    String? cardNumber,
    int? cardExpMonth,
    int? cardExpYear,
    int? cardCvc,
  }) =>
      SubscriptionCard(
        cardOwnerName: cardOwnerName ?? this.cardOwnerName,
        cardNumber: cardNumber ?? this.cardNumber,
        cardExpMonth: cardExpMonth ?? this.cardExpMonth,
        cardExpYear: cardExpYear ?? this.cardExpYear,
        cardCvc: cardCvc ?? this.cardCvc,
      );

  factory SubscriptionCard.fromJson(Map<String, dynamic> json) => SubscriptionCard(
    cardOwnerName: json["card_owner_name"],
    cardNumber: json["card_number"],
    cardExpMonth: json["card_exp_month"],
    cardExpYear: json["card_exp_year"],
    cardCvc: json["card_cvc"],
  );

  Map<String, dynamic> toJson() => {
    "card_owner_name": cardOwnerName,
    "card_number": cardNumber,
    "card_exp_month": cardExpMonth,
    "card_exp_year": cardExpYear,
    "card_cvc": cardCvc,
  };
}
