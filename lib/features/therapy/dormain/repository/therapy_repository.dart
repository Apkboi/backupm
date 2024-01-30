import 'package:mentra/features/therapy/data/models/accept_therapist_response.dart';
import 'package:mentra/features/therapy/data/models/create_session_response.dart';
import 'package:mentra/features/therapy/data/models/create_sessions_payload.dart';
import 'package:mentra/features/therapy/data/models/fetch_dates_response.dart';
import 'package:mentra/features/therapy/data/models/fetch_time_slots_response.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';

abstract class TherapyRepository {
  Future<FetchDatesResponse> getAvailableDate();

  Future<FetchTimeSlotsResponse> getAvailableTimeSlots(String date);

  Future<UpcomingSessionsResponse> getUpcomingSessions();

  Future<UpcomingSessionsResponse> getSessionsHistory();

  Future<CreateSessionResponse> createSession(CreateSessionPayload payload);

  Future<CreateSessionResponse> rescheduleSession(CreateSessionPayload payload);

  Future<CreateSessionResponse> cancelSession(
      {required String sessionId, String? note});

  Future<MatchTherapistResponse> matchTherapist();

  Future<AcceptTherapistResponse> acceptTherapist({
    required String therapistId,
  });
}
