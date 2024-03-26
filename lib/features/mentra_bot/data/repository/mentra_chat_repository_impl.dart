import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/mentra_bot/data/models/get_current_sessions_response.dart';
import 'package:mentra/features/mentra_bot/dormain/repository/mentra_chat_repository.dart';

class MentraChatRepositoryImpl extends MentraChatRepository {
  final NetworkService _networkService;

  MentraChatRepositoryImpl(this._networkService);

  @override
  Future<GetCurrentSessionRsponse> continueSession(
      String sessionId, String prompt) async {
    try {
      final response = await _networkService.call(
          UrlConfig.continueSession, RequestMethod.post,
          data: {"ai_session_id": sessionId, "prompt": prompt});

      return GetCurrentSessionRsponse.fromJson(response.data);
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }

  @override
  Future endSession(String sessionId) async {
    try {
      final response = await _networkService.call(
        UrlConfig.continueSession,
        RequestMethod.post,
      );

      return response.data;
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }

  @override
  Future<GetCurrentSessionRsponse> getCurrentSession() async {
    try {
      final response = await _networkService.call(
        UrlConfig.currentSession,
        RequestMethod.get,
      );

      return GetCurrentSessionRsponse.fromJson(response.data);
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }
}
