import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/dashboard/data/models/conversation_starter_response.dart';
import 'package:mentra/features/dashboard/data/models/emergency_contacts.dart';
import 'package:mentra/features/dashboard/data/models/update_mood_checker_response.dart';
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

  @override
  Future<GetEmergencyContactsResponse> getEmergencyContacts() async {
    try {
      final response = await _networkService.call(
          UrlConfig.getEmergencyContacts, RequestMethod.get);
      return GetEmergencyContactsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);

      rethrow;
    }
  }

  @override
  Future<UpdateMoodCheckerResponse> updateMoodChecker(String mood) async {
    try {
      final response = await _networkService.call(
          UrlConfig.updateMoodChecker, RequestMethod.post,data: {
            "mood":mood
      });
      return  UpdateMoodCheckerResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);

      rethrow;
    }
  }
}
