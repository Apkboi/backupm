part of 'session_bloc.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class GetMessagesEvent extends SessionEvent {
  List<Object?> get props => [];
}

class SendMessageEvent extends SessionEvent {
  List<Object?> get props => [];
}

class MessageReceivedEvent extends SessionEvent {
  final dynamic message;

  MessageReceivedEvent(this.message);

  List<Object?> get props => [message];
}
