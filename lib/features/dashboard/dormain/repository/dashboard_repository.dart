import 'package:mentra/features/dashboard/data/models/conversation_starter_response.dart';

abstract class DashboardRepository {
  Future<ConversationStarterResponse> getConversationStarter();
}


