// To parse this JSON data, do
//
//     final createIntentResponse = createIntentResponseFromJson(jsonString);

import 'dart:convert';

CreateIntentResponse createIntentResponseFromJson(String str) => CreateIntentResponse.fromJson(json.decode(str));

String createIntentResponseToJson(CreateIntentResponse data) => json.encode(data.toJson());

class CreateIntentResponse {
  final String message;
  final Data data;
  final bool success;
  final int code;

  CreateIntentResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  CreateIntentResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      CreateIntentResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory CreateIntentResponse.fromJson(Map<String, dynamic> json) => CreateIntentResponse(
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
  final String paymentIntent;
  final String clientSecret;
  final int amount;

  Data({
    required this.paymentIntent,
    required this.clientSecret,
    required this.amount,
  });

  Data copyWith({
    String? paymentIntent,
    String? clientSecret,
    int? amount,
  }) =>
      Data(
        paymentIntent: paymentIntent ?? this.paymentIntent,
        clientSecret: clientSecret ?? this.clientSecret,
        amount: amount ?? this.amount,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentIntent: json["payment_intent"],
    clientSecret: json["client_secret"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "payment_intent": paymentIntent,
    "client_secret": clientSecret,
    "amount": amount,
  };
}
