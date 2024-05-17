import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/subscription/data/models/create_payment_intent_response.dart';
import 'package:mentra/features/subscription/data/models/get_plans_response.dart';
import 'package:mentra/features/subscription/data/models/subscribe_response.dart';
import 'package:mentra/features/subscription/data/models/subscription_payload.dart';
import 'package:mentra/features/subscription/dormain/repository/subscription_repository.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final NetworkService _networkService;

  SubscriptionRepositoryImpl(this._networkService);

  @override
  Future<GetPlansResponse> getPlans() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPlans,
        RequestMethod.get,
      );
      return GetPlansResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubscribeResponse> subscribe(SubscriptionPayload payload) async {
    try {
      final response = await _networkService.call(
          UrlConfig.subscribe, RequestMethod.post,
          data: payload.toJson());
      return SubscribeResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreateIntentResponse> createPaymentIntent(
      SubscriptionPayload payload) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getPaymentIntent, RequestMethod.post,
          data: {"plan_duration_id": payload.planDurationId});
      return CreateIntentResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future cancelSubscription(String id) async {
    try {
      final response = await _networkService.call(
        UrlConfig.cancelSubscription(id),
        RequestMethod.post,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
