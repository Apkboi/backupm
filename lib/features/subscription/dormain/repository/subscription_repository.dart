import 'package:mentra/features/subscription/data/models/create_payment_intent_response.dart';
import 'package:mentra/features/subscription/data/models/get_plans_response.dart';
import 'package:mentra/features/subscription/data/models/subscribe_response.dart';
import 'package:mentra/features/subscription/data/models/subscription_payload.dart';

abstract class SubscriptionRepository {
  Future<SubscribeResponse> subscribe(SubscriptionPayload payload);

  Future<GetPlansResponse> getPlans();
  Future<CreateIntentResponse> createPaymentIntent(SubscriptionPayload payload);
}
