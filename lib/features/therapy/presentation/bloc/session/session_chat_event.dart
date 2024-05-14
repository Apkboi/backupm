part of 'session_chat_bloc.dart';

abstract class SessionChatEvent {
  const SessionChatEvent();
}

class GetMessagesEvent extends SessionChatEvent {
  List<Object?> get props => [];
}

class SendMessageEvent extends SessionChatEvent {
  final TherapyChatMessage message;

  SendMessageEvent(this.message);

  List<Object?> get props => [];
}

class MessageReceivedEvent extends SessionChatEvent {
  final TherapyChatMessage message;

  MessageReceivedEvent(this.message);

  List<Object?> get props => [message];
}

class RetryTherapyMessageEvent extends SessionChatEvent {
  final TherapyChatMessage message;

  RetryTherapyMessageEvent(this.message);

  List<Object?> get props => [message];
}
