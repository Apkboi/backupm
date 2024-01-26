import 'package:mentra/features/therapy/presentation/data/models/fetch_dates_response.dart';
import 'package:mentra/features/therapy/presentation/data/models/upcoming_sessions_response.dart';

abstract class TherapyRepository {

  Future<FetchDatesResponse> getAvailableDate();
  Future<dynamic> getAvailableTimeSlots(String date);
  Future<UpcomingSessionsResponse> getUpcomingSessions();
  Future<UpcomingSessionsResponse> getSessionsHistory();
  Future<dynamic> createSession(dynamic payload);
  Future<dynamic> rescheduleSession(dynamic payload);
  Future<dynamic> cancelSession(String sessionId, String note);


}