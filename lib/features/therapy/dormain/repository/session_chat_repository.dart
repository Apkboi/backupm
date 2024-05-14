
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';

abstract class SessionChatRepository {
  Future<dynamic> sendMessage(TherapyChatMessage message);
  Future<dynamic> getConversations();
  Future<dynamic> getMessages();
  Future<dynamic> deleteMessage(int messageId);
  Future<dynamic> deleteConversation(int conversationId);
}