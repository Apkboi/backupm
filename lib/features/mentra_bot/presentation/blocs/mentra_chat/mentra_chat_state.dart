part of 'mentra_chat_bloc.dart';

abstract class MentraChatState extends Equatable {
  const MentraChatState();
}

class MentraChatInitial extends MentraChatState {
  @override
  List<Object> get props => [];
}

class GetCurrentSessionLoading extends MentraChatState {
  @override
  List<Object> get props => [];
}

class SignupMessageAdded extends MentraChatState {
  @override
  List<Object> get props => [];
}

class GetCurrentSessionSuccessState extends MentraChatState {
  final GetCurrentSessionRsponse response;

  const GetCurrentSessionSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GetCurrentSessionFailureState extends MentraChatState {
  final String error;

  const GetCurrentSessionFailureState(this.error);

  @override
  List<Object> get props => [];
}

class ContinueSessionLoading extends MentraChatState {
  @override
  List<Object> get props => [];
}

class ContinueSessionSuccessState extends MentraChatState {
  final dynamic response;

  const ContinueSessionSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class MessageUpdatedState extends MentraChatState {
  final List<MentraChatModel> response;

  const MessageUpdatedState(this.response);

  @override
  List<Object?> get props => [const Uuid().v1()];
}

class ContinueSessionFailureState extends MentraChatState {
  final String error;

  const ContinueSessionFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class EndMentraSessionLoading extends MentraChatState {
  @override
  List<Object> get props => [];
}

class EndMentraSessionnSuccessState extends MentraChatState {
  final dynamic response;

  const EndMentraSessionnSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class EndMentraSessionFailureState extends MentraChatState {
  final String error;

  const EndMentraSessionFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class RetryMessageFailureState extends MentraChatState {
  final String error;

  const RetryMessageFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class RetryMessageLoadingState extends MentraChatState {
  const RetryMessageLoadingState();

  @override
  List<Object> get props => [];
}

class ReviewMentraSessionFailureState extends MentraChatState {
  final String error;

  const ReviewMentraSessionFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class ReviewMentraSessionSuccessState extends MentraChatState {
  final dynamic response;

  const ReviewMentraSessionSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class ReviewMentraLoadingState extends MentraChatState {
  const ReviewMentraLoadingState();

  @override
  List<Object> get props => [];
}

class PopulateChatSuccessState extends MentraChatState {
  @override
  List<Object> get props => [];
}

class PopulateChatFailedState extends MentraChatState {
  final String error;

  const PopulateChatFailedState(this.error);

  @override
  List<Object> get props => [error];
}
