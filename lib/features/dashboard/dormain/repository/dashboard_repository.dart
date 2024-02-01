import 'package:mentra/features/dashboard/data/models/conversation_starter_response.dart';
import 'package:mentra/features/dashboard/data/models/emergency_contacts.dart';

abstract class DashboardRepository {
  Future<ConversationStarterResponse> getConversationStarter();

  Future<GetEmergencyContactsResponse> getEmergencyContacts();
}
