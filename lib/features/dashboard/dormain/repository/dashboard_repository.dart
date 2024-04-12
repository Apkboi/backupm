import 'package:mentra/features/dashboard/data/models/conversation_starter_response.dart';
import 'package:mentra/features/dashboard/data/models/emergency_contacts.dart';
import 'package:mentra/features/dashboard/data/models/update_mood_checker_response.dart';

abstract class DashboardRepository {
  Future<ConversationStarterResponse> getConversationStarter();

  Future<GetEmergencyContactsResponse> getEmergencyContacts();
  Future<UpdateMoodCheckerResponse> updateMoodChecker(String mood);
}
