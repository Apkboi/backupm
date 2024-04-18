import 'package:mentra/features/mentra_bot/data/models/get_current_sessions_response.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';

abstract class MentraChatRepository {
  Future<GetCurrentSessionRsponse> getCurrentSession();

  Future<GetCurrentSessionRsponse> continueSession(
      String sessionId, String prompt);

  Future<dynamic> endSession(
      {required String sessionId, required String? feeling, String? comment});

  Future<dynamic> reviewMentraSession(
      {required String sessionId, required String? feeling, String? comment});

  Future<dynamic> populateChat(
      {required String sessionId, required List<MentraChatModel> messages});
}
