part of 'session_chat_bloc.dart';

abstract class SessionChatState extends Equatable {
  const SessionChatState();
}

class SessionInitial extends SessionChatState {
  @override
  List<Object> get props => [];
}

class MessagesFetchedEvent extends SessionChatState {
  @override
  List<Object> get props => [];
}

class SendMessageLoadingState extends SessionChatState {
  @override
  List<Object> get props => [];
}

class SendMessageFailedState extends SessionChatState {
  @override
  List<Object> get props => [];
}

class SendMessageSuccesState extends SessionChatState {
  @override
  List<Object> get props => [];
}

class GetMessagesLoadingState extends SessionChatState {
  @override
  List<Object> get props => [];
}

class GetMessagesFailedState extends SessionChatState {
  final String error;

  const GetMessagesFailedState(this.error);

  @override
  List<Object> get props => [];
}

class GetMessagesSuccesState extends SessionChatState {
  final GetAllMessagesResponse response;

  const GetMessagesSuccesState(this.response);

  @override
  List<Object> get props => [];
}
