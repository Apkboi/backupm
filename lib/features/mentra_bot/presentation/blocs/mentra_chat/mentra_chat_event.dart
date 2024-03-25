part of 'mentra_chat_bloc.dart';

abstract class MentraChatEvent extends Equatable {
  const MentraChatEvent();
}

class GetCurrentSessionEvent extends MentraChatEvent {
  @override
  List<Object?> get props => [];
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
  String sessionId;

  EndMentraSessionEvent(
    this.sessionId,
  );

  @override
  List<Object?> get props => [
        sessionId,
      ];
}
