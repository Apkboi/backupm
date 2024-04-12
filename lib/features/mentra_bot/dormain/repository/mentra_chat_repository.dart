import 'package:mentra/features/mentra_bot/data/models/get_current_sessions_response.dart';

abstract class MentraChatRepository {
  Future<GetCurrentSessionRsponse> getCurrentSession();

  Future<GetCurrentSessionRsponse> continueSession(
      String sessionId, String prompt);

  Future<dynamic> endSession(
      {required String sessionId,
      required String? feeling,
       String? comment});
}
