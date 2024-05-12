import 'package:mentra/features/therapy/data/models/get_offer_response.dart';

/// Abstract class defining methods for Call related network operations
abstract class CallRepository {
  Future<GetOfferResponse> getOffer(int callerId);

  Future<void> answerCall(int callerId, Map<String, dynamic> answer,String calleeId,String sessionId);

  Future<void> endCall(
      int callerId, int calleeId, String sessionId, String sender);

  Future<void> pushCandidate(int callerId, Map<String, dynamic> candidate,String calleeId,String sessionId);

  Future<void> callAction(int callerId, int calleeId, String sessionId,
      String action, String value);

  Future<void> offerCall(int callerId, int calleeId, int sessionId, Map<String, dynamic> offer);
}
