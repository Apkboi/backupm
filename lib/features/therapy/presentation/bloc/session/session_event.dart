part of 'session_bloc.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class GetMessagesEvent extends SessionEvent {
  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends SessionEvent {
  @override
  List<Object?> get props => [];
}

class MessageReceivedEvent extends SessionEvent {
  final MesiboMessage message;

  MessageReceivedEvent(this.message);

  @override
  List<Object?> get props => [message];
}
