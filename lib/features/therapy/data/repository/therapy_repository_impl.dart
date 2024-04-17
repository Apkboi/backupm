import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/therapy/data/models/accept_therapist_response.dart';
import 'package:mentra/features/therapy/data/models/create_session_response.dart';
import 'package:mentra/features/therapy/data/models/create_sessions_payload.dart';
import 'package:mentra/features/therapy/data/models/fetch_dates_response.dart';
import 'package:mentra/features/therapy/data/models/fetch_time_slots_response.dart';
import 'package:mentra/features/therapy/data/models/get_matched_therapist.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/data/models/session_focus_response.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/dormain/repository/therapy_repository.dart';

class TherapyRepositoryImpl extends TherapyRepository {
  final NetworkService _networkService;

  TherapyRepositoryImpl(this._networkService);

  @override
  Future<FetchDatesResponse> getAvailableDate() async {
    final response =
        await _networkService.call(UrlConfig.fetchDates, RequestMethod.post);

    return FetchDatesResponse.fromJson(response.data);
  }

  @override
  Future<FetchTimeSlotsResponse> getAvailableTimeSlots(String date) async {
    try {
      final response = await _networkService.call(
          UrlConfig.sessionTimeSlots, RequestMethod.post,
          data: {"date": date});

      return FetchTimeSlotsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
      // TODO
    }
  }

  @override
  Future<UpcomingSessionsResponse> getUpcomingSessions() async {
    final response = await _networkService.call(
        UrlConfig.upcomingSessions, RequestMethod.get);

    return UpcomingSessionsResponse.fromJson(response.data);
  }

  @override
  Future<UpcomingSessionsResponse> getSessionsHistory() async {
    final response =
        await _networkService.call(UrlConfig.sessionHistory, RequestMethod.get);

    return UpcomingSessionsResponse.fromJson(response.data);
  }

  @override
  Future<CreateSessionResponse> createSession(
      CreateSessionPayload payload) async {
    try {
      final response = await _networkService.call(
          UrlConfig.createSession, RequestMethod.post,
          data: payload.toJson());

      return CreateSessionResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
    }
  }

  @override
  Future<CreateSessionResponse> rescheduleSession(
      CreateSessionPayload payload) async {
    try {
      final response = await _networkService.call(
          UrlConfig.rescheduleSession, RequestMethod.post,
          data: payload.toJson());

      return CreateSessionResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<CreateSessionResponse> cancelSession(
      {required String sessionId, String? note}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.cancelSession, RequestMethod.post,
          data: {"session_id": sessionId, "note": note});

      return CreateSessionResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<AcceptTherapistResponse> acceptTherapist(
      {required String therapistId}) async {
    try {
      final response = await _networkService
          .call(UrlConfig.selectTherapist, RequestMethod.post, data: {
        "therapist_user_id": therapistId,
      });

      return AcceptTherapistResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<MatchTherapistResponse> matchTherapist() async {
    try {
      final response = await _networkService.call(
        UrlConfig.matchTherapist,
        RequestMethod.post,
      );

      return MatchTherapistResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future<GetMatchedTherapistResponse> getMatchedTherapist() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getMatchedTherapist,
        RequestMethod.get,
      );
      return GetMatchedTherapistResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future<SuccessResponse> createReview({
    required String sessionId,
    required String comment,
    required int rating,
  }) async {
    try {
      final response = await _networkService.call(
          UrlConfig.createReview, RequestMethod.post, data: {
        "therapy_session_id": sessionId,
        "comment": comment,
        "rating": rating.toString()
      });
      return SuccessResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future getTherapistReview() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getReviews,
        RequestMethod.get,
      );
      return response.data;
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future<SessionFocusResponse> getSessionFocus() async {
    try {
      final response = await _networkService.call(
        UrlConfig.sessionFocus,
        RequestMethod.get,
      );
      return SessionFocusResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future report({required String content}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.report, RequestMethod.post,
          data: {"content": content});
      return response.data;
    } catch (e, stack) {
      // logger.e(e);
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }
}
