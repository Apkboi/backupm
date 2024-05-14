import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/therapy/data/models/get_all_messages_response.dart';
import 'package:mentra/features/therapy/data/models/get_messages_response.dart';
import 'package:mentra/features/therapy/data/models/send_message_response.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';
import 'package:mentra/features/therapy/dormain/repository/session_chat_repository.dart';

class SessionChatRepositoryImpl extends SessionChatRepository {
  final NetworkService _networkService;

  SessionChatRepositoryImpl(this._networkService);

  @override
  Future<SendMessageRsponse> sendMessage(TherapyChatMessage message) async {
    try {
      final response = await _networkService.call(
          UrlConfig.sendMessage, RequestMethod.post, data: {
        "receiver_id": message.receiverId,
        "message": message.message
      });

      return SendMessageRsponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getConversations() async {
    try {
      final response = await _networkService.call(
          UrlConfig.getConversations, RequestMethod.get);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetMessagesResponse> getMessages() async {
    try {
      final response =
          await _networkService.call(UrlConfig.getMessages, RequestMethod.get);

      return GetMessagesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteMessage(int messageId) async {
    final response = await _networkService.call(
        UrlConfig.deleteMessage(messageId), RequestMethod.delete);

    return response.data;
  }

  @override
  Future<dynamic> deleteConversation(int conversationId) async {
    final response = await _networkService.call(
        UrlConfig.deleteConversation(conversationId), RequestMethod.delete);

    return response.data;
  }
}
