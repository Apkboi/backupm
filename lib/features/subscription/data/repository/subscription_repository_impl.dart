import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/subscription/data/models/subscription_payload.dart';
import 'package:mentra/features/subscription/dormain/repository/subscription_repository.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final NetworkService _networkService;

  SubscriptionRepositoryImpl(this._networkService);

  @override
  Future getPlans() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPlans,
        RequestMethod.get,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future subscribe(SubscriptionPayload payload) async {
    try {
      final response = await _networkService
          .call(UrlConfig.getPlans, RequestMethod.post, data: {});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
