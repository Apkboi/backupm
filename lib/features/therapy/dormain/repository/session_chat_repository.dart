import 'package:mentra/features/therapy/data/models/get_messages_response.dart';
import 'package:mentra/features/therapy/data/models/send_message_response.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';

abstract class SessionChatRepository {
  Future<SendMessageRsponse> sendMessage(TherapyChatMessage message);

  Future<dynamic> getConversations();

  Future<GetMessagesResponse> getMessages(String id);

  Future<dynamic> deleteMessage(int messageId);

  Future<dynamic> deleteConversation(int conversationId);
}
