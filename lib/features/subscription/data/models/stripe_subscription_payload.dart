import 'package:mentra/features/subscription/data/models/create_payment_intent_response.dart';

enum PaymentType { onTime, reOcurring }

class StripeSubscriptionPayload {
  CreateIntentResponse intent;
  PaymentType paymentType;
  final bool enablePlatformPay;
  final String plan;

  StripeSubscriptionPayload(
      {required this.intent,
      required this.paymentType,
      required this.plan,
      required this.enablePlatformPay});
}
