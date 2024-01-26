import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/dashboard/data/models/conversation_starter_response.dart';
import 'package:mentra/features/dashboard/dormain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final NetworkService _networkService;

  DashboardRepositoryImpl(this._networkService);

  @override
  Future<ConversationStarterResponse> getConversationStarter() async {
    final response = await _networkService.call(
        UrlConfig.getConversationStarterEndpoint, RequestMethod.get);

    return ConversationStarterResponse.fromJson(response.data);
  }
}
