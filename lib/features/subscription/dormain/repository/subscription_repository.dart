import 'package:mentra/features/subscription/data/models/subscription_payload.dart';

abstract class SubscriptionRepository{
  Future<dynamic> subscribe(SubscriptionPayload payload);
  Future<dynamic> getPlans();
}