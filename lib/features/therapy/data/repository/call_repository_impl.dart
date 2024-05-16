import 'dart:convert';

import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/therapy/data/models/get_offer_response.dart';
import 'package:mentra/features/therapy/dormain/repository/call_repository.dart';

/// Implementation of CallRepository using NetworkService
class CallRepositoryImpl implements CallRepository {
  final NetworkService _networkService;

  CallRepositoryImpl(this._networkService);

  @override
  Future<GetOfferResponse> getOffer(int callerId) async {
    final response = await _networkService.call(
      UrlConfig.getOffer(callerId),
      RequestMethod.get,
    );
    return GetOfferResponse.fromJson(response.data);
  }

  @override
  Future<void> answerCall(int callerId, Map<String, dynamic> answer,
      String calleeId, String sessionId) async {
    final body = {
      "callerId": callerId,
      "calleeId": calleeId,
      // Replace with current user id
      "therapy_session_id": sessionId,
      // You might need to fill this based on your logic
      "sdpAnswer": base64.encode(utf8.encode(jsonEncode(answer))),
    };
    await _networkService.call(
      UrlConfig.answerCall,
      RequestMethod.post,
      data: body,
    );
  }

  @override
  Future<void> endCall(
      int callerId, int calleeId, String sessionId, String sender) async {
    final body = {
      "callerId": callerId,
      "calleeId": calleeId,
      "sender": sender,
      "therapy_session_id": sessionId,
    };
    await _networkService.call(
      UrlConfig.endCall,
      RequestMethod.post,
      data: body,
    );
  }

  @override
  Future<void> pushCandidate(int callerId, Map<String, dynamic> candidate,
      String calleeId, String sessionId) async {
    final body = {
      "callerId": callerId,
      "calleeId": calleeId,
      // Replace with current user id
      "therapy_session_id": sessionId,
      // You might need to fill this based on your logic
      "iceCandidate": base64.encode(utf8.encode(jsonEncode(candidate))),
      "sender": "user"
    };
    await _networkService.call(
      UrlConfig.iceCandidate,
      RequestMethod.post,
      data: body,
    );
  }

  @override
  Future<void> callAction(int callerId, int calleeId, String sessionId,
      String action, String value) async {
    final body = {
      "callerId": callerId,
      "calleeId": calleeId,
      "therapy_session_id": sessionId,
      "action": action,
      "value": value,
    };
    await _networkService.call(
      UrlConfig.callAction,
      RequestMethod.post,
      data: body,
    );
  }

  @override
  Future<void> offerCall(int callerId, int calleeId, String sessionId,
      Map<String, dynamic> offer) async {
    try {
      var networkService = injector.get<NetworkService>();
      var body = {
        "callerId": calleeId,
        "calleeId": callerId,
        "therapy_session_id": sessionId,
        "sdpOffer": base64.encode(utf8.encode(jsonEncode(offer))),
      };

      await networkService.call(UrlConfig.makeCall, RequestMethod.post,
          data: body);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
