import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/therapy/presentation/data/models/fetch_dates_response.dart';
import 'package:mentra/features/therapy/presentation/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/dormain/repository/therapy_repository.dart';

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
  Future<dynamic> getAvailableTimeSlots(String date) async {
    final response = await _networkService.call(
        UrlConfig.sessionTimeSlots, RequestMethod.get,
        data: {"date": date});

    return response.data;
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
  Future<dynamic> createSession(dynamic payload) async {
    final response = await _networkService.call(
        UrlConfig.createSession, RequestMethod.post,
        data: payload.toJson());

    return response.data;
  }

  @override
  Future<dynamic> rescheduleSession(dynamic payload) async {
    final response = await _networkService.call(
        UrlConfig.rescheduleSession, RequestMethod.post,
        data: payload.toJson());

    return response.data;
  }

  @override
  Future<dynamic> cancelSession(String sessionId, String note) async {
    final response = await _networkService.call(
        UrlConfig.cancelSession, RequestMethod.post,
        data: {"sessionId": sessionId, "note": note});

    return response.data;
  }
}
