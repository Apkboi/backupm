part of 'bot_chat_cubit.dart';

abstract class BotChatState {
  const BotChatState();
}

class BotChatInitial extends BotChatState {
  @override
  List<Object> get props => [];
}

class RemoveTypingState extends BotChatState {
  @override
  List<Object> get props => [];
}

class QuestionUpdatedState extends BotChatState {
  @override
  List<Object> get props => [];
}
