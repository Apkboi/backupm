part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
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
  @override
  List<Object?> get props => [];
}
