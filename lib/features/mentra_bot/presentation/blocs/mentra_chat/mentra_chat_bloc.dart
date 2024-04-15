import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/services/sound/sound_manager.dart';
import 'package:mentra/features/mentra_bot/data/models/get_current_sessions_response.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/dormain/repository/mentra_chat_repository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'mentra_chat_event.dart';

part 'mentra_chat_state.dart';

class MentraChatBloc extends Bloc<MentraChatEvent, MentraChatState> {
  final MentraChatRepository _repository;
  List<MentraChatModel> messagesFromAuthenticationFlow = [];
  List<MentraChatModel> allMessages = [];
  final scrollController = ItemScrollController();
  String sessionId = '';

  MentraChatBloc(this._repository) : super(MentraChatInitial()) {
    on<MentraChatEvent>((event, emit) {});
    on<GetCurrentSessionEvent>(_mapGetCurrentSessionEventToState);
    on<ContinueSessionEvent>(_mapContinueSessionEventToState);
    on<EndMentraSessionEvent>(_mapEndMentraSessionEventToState);
    on<RetryMessageEvent>(_mapRetryMessageEventToState);
    on<AddAuthMessagesEvent>(_mapAddSignupMessagesEventToState);
    on<ReviewMentraSessionEvent>(_mapReviewMentraSessionEventToState);
  }

  void _scrollToLast() async {
    // TODO:REMOVE THIS FUNCTION
  }

  FutureOr<void> _mapGetCurrentSessionEventToState(
      GetCurrentSessionEvent event, Emitter<MentraChatState> emit) async {
    await _removeTyping();

    emit(GetCurrentSessionLoading());

    if (messagesFromAuthenticationFlow.isEmpty) {
      allMessages.clear();
    }
    _addTyping();

    try {
      final response = await _repository.getCurrentSession();
      sessionId = response.data.id.toString();
      allMessages = [
        ...messagesFromAuthenticationFlow,
        ...response.data.messages
            .where((element) => element.user != 'system')
            .map((e) => MentraChatModel.fromResponse(e))
      ];
      await _removeTyping();

      emit(MessageUpdatedState(allMessages));
      _scrollToLast();
      emit(GetCurrentSessionSuccessState(response));
    } catch (e) {
      emit(GetCurrentSessionFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapContinueSessionEventToState(
      ContinueSessionEvent event, Emitter<MentraChatState> emit) async {
    SoundManager.playMessageSentSound();
    final MentraChatModel message = MentraChatModel.fromPrompt(event.prompt);
    allMessages.add(message);
    _addTyping();
    _scrollToLast();
    emit(ContinueSessionLoading());
    try {
      final response =
          await _repository.continueSession(event.sessionId, event.prompt);
      // emit(ContinueSessionSuccessState(response));

      allMessages = [
        ...messagesFromAuthenticationFlow,
        ...response.data.messages
            .where((element) => element.user != 'system')
            .map((e) => MentraChatModel.fromResponse(e))
      ];
      _removeTyping();
      SoundManager.playMessageReceivedSound();

      emit(MessageUpdatedState(allMessages));
      _scrollToLast();
    } catch (e) {
      _removeTyping();
      final updatedMessage = message..sendingState = SendingState.failed;
      allMessages.map((msg) => msg == message ? updatedMessage : msg).toList();
      emit(ContinueSessionFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapEndMentraSessionEventToState(
      EndMentraSessionEvent event, Emitter<MentraChatState> emit) async {
    emit(EndMentraSessionLoading());
    // _addTyping();
    try {
      final response = await _repository.endSession(
          sessionId: event.sessionId,
          feeling: event.feeling,
          comment: event.comment);
      emit(EndMentraSessionnSuccessState(response));
    } catch (e) {
      emit(EndMentraSessionFailureState(e.toString()));
    }
  }

  void _addTyping() async {
    allMessages.add(MentraChatModel.typing());
    emit(MessageUpdatedState(allMessages));
  }

  Future _removeTyping() async {
    allMessages.removeWhere((element) => element.isTyping == true);
  }

  FutureOr<void> _mapRetryMessageEventToState(
      RetryMessageEvent event, Emitter<MentraChatState> emit) async {
    final MentraChatModel loadingMessage = event.message
      ..sendingState = SendingState.loading;
    allMessages
        .map((msg) => msg == event.message ? loadingMessage : msg)
        .toList();
    await _removeTyping();
    _addTyping();
    _scrollToLast();
    emit(const RetryMessageLoadingState());
    try {
      final response =
          await _repository.continueSession(sessionId, event.message.content);
      allMessages = [
        ...messagesFromAuthenticationFlow,
        ...response.data.messages
            .where((element) => element.user != 'system')
            .map((e) => MentraChatModel.fromResponse(e))
      ];
      _removeTyping();

      emit(MessageUpdatedState(allMessages));
      _scrollToLast();
    } catch (e) {
      _removeTyping();
      final updatedMessage = loadingMessage..sendingState = SendingState.failed;
      allMessages
          .map((msg) => msg == loadingMessage ? updatedMessage : msg)
          .toList();
      emit(ContinueSessionFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapAddSignupMessagesEventToState(
      AddAuthMessagesEvent event, Emitter<MentraChatState> emit) {
    messagesFromAuthenticationFlow.addAll(event.signupMessages);
    allMessages = messagesFromAuthenticationFlow
        .where((element) => element.isTyping == false)
        .toList();
    emit(SignupMessageAdded());
  }

  FutureOr<void> _mapReviewMentraSessionEventToState(
      ReviewMentraSessionEvent event, Emitter<MentraChatState> emit) async {
    emit(const ReviewMentraLoadingState());
    // _addTyping();
    try {
      final response = await _repository.reviewMentraSession();
      emit(ReviewMentraSessionSuccessState(response));
    } catch (e) {
      emit(ReviewMentraSessionFailureState(e.toString()));
    }
  }
}
