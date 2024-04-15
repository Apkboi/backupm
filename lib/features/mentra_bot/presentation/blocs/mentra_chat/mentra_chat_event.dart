part of 'mentra_chat_bloc.dart';

abstract class MentraChatEvent extends Equatable {
  const MentraChatEvent();
}

class GetCurrentSessionEvent extends MentraChatEvent {
  @override
  List<Object?> get props => [];
}

class AddAuthMessagesEvent extends MentraChatEvent {
  final List<MentraChatModel> signupMessages;

  const AddAuthMessagesEvent(this.signupMessages);

  @override
  List<Object?> get props => [signupMessages];
}

class ContinueSessionEvent extends MentraChatEvent {
  String sessionId;
  String prompt;

  ContinueSessionEvent(this.sessionId, this.prompt);

  @override
  List<Object?> get props => [sessionId, prompt];
}

class RetryMessageEvent extends MentraChatEvent {
  MentraChatModel message;

  RetryMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class EndMentraSessionEvent extends MentraChatEvent {
  final String sessionId;
  final String? feeling;
  final String? comment;

  const EndMentraSessionEvent(
    this.sessionId, {
    this.feeling,
    this.comment,
  });

  @override
  List<Object?> get props => [sessionId, feeling, comment];
}

class ReviewMentraSessionEvent extends MentraChatEvent {
  dynamic payload;

  ReviewMentraSessionEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}
