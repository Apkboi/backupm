import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/mentra_bot/data/models/get_current_sessions_response.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
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
  Future endSession(
      {required String sessionId,
      required String? feeling,
      String? comment}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.endSession, RequestMethod.post, data: {
        "ai_session_id": sessionId,
        "feeling": feeling,
        "comment": comment
      });

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
    } catch (e, stack) {
      logger.i(e.toString());
      logger.i(stack.toString());
      rethrow;
    }
  }

  @override
  Future reviewMentraSession(
      {required String sessionId,
      required String? feeling,
      String? comment}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.reviewAiSession, RequestMethod.post, data: {
        "ai_session_id": sessionId,
        "feeling": feeling,
        "comment": comment
      });

      return GetCurrentSessionRsponse.fromJson(response.data);
    } catch (e, stack) {
      logger.i(e.toString());
      logger.i(stack.toString());
      rethrow;
    }
  }

  @override
  Future populateChat(
      {required String sessionId,
      required List<MentraChatModel> messages}) async {

    messages.removeLast();
    try {
      final response = await _networkService
          .call(UrlConfig.populateChat, RequestMethod.post, data: {
        "ai_session_id": sessionId,
        "messages": messages.map((e) => e.toRequestJson()).toList()
      });

      return GetCurrentSessionRsponse.fromJson(response.data);
    } catch (e, stack) {
      logger.i(e.toString());
      logger.i(stack.toString());
      rethrow;
    }
  }
}
