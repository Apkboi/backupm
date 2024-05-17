class PaymentPayload {
  String amount;
  String currency;
  String clientSecret;
  String paymentLabel;
  String ephemeralKey;

  PaymentPayload(
      {required this.amount,
      required this.currency,
      required this.clientSecret,
      required this.paymentLabel,
      required this.ephemeralKey});
}
