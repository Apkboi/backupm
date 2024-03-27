import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:mentra/features/mentra_bot/data/models/get_current_sessions_response.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/dormain/repository/mentra_chat_repository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'mentra_chat_event.dart';

part 'mentra_chat_state.dart';

class MentraChatBloc extends Bloc<MentraChatEvent, MentraChatState> {
  final MentraChatRepository _repository;
  List<MentraChatModel> allMessage = [];
  final scrollController = ItemScrollController();
  String sessionId = '';

  MentraChatBloc(this._repository) : super(MentraChatInitial()) {
    on<MentraChatEvent>((event, emit) {});
    on<GetCurrentSessionEvent>(_mapGetCurrentSessionEventToState);
    on<ContinueSessionEvent>(_mapContinueSessionEventToState);
    on<EndMentraSessionEvent>(_mapEndMentraSessionEventToState);
    on<RetryMessageEvent>(_mapRetryMessageEventToState);
  }

  void _scrollToLast() async {
    // scrollController.scrollTo(
    //   alignment: 0.5,
    //   index: 0,
    //   duration: const Duration(milliseconds: 800),
    //   curve: Curves.easeInOut,
    // );
  }

  FutureOr<void> _mapGetCurrentSessionEventToState(
      GetCurrentSessionEvent event, Emitter<MentraChatState> emit) async {
    emit(GetCurrentSessionLoading());
    allMessage.clear();
    _addTyping();
    // _scrollToLast();
    try {
      final response = await _repository.getCurrentSession();

      sessionId = response.data.id.toString();
      allMessage = response.data.messages
          .where((element) => element.user != 'system')
          .map((e) => MentraChatModel.fromResponse(e))
          .toList();
      emit(MessageUpdatedState(allMessage));
      _scrollToLast();

      emit(GetCurrentSessionSuccessState(response));
    } catch (e) {
      emit(GetCurrentSessionFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapContinueSessionEventToState(
      ContinueSessionEvent event, Emitter<MentraChatState> emit) async {
    final MentraChatModel message = MentraChatModel.fromPrompt(event.prompt);
    allMessage.add(message);
    _addTyping();
    _scrollToLast();
    emit(ContinueSessionLoading());
    try {
      final response =
          await _repository.continueSession(event.sessionId, event.prompt);
      // emit(ContinueSessionSuccessState(response));

      allMessage = response.data.messages
          .where((element) => element.user != 'system')
          .map((e) => MentraChatModel.fromResponse(e))
          .toList();

      emit(MessageUpdatedState(allMessage));
      _scrollToLast();
    } catch (e) {
      _removeTyping();
      final updatedMessage = message..sendingState = SendingState.failed;
      allMessage.map((msg) => msg == message ? updatedMessage : msg).toList();
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
    // await Future.delayed(const Duration(seconds: 1));
    allMessage.add(MentraChatModel.typing());
    emit(MessageUpdatedState(allMessage));
  }

  Future _removeTyping() async {
    await Future.delayed(const Duration(milliseconds: 400));
    allMessage.removeWhere((element) => element.isTyping == true);
    emit(MessageUpdatedState(allMessage));

    // await Future.delayed(const Duration(milliseconds: 300));
  }

  FutureOr<void> _mapRetryMessageEventToState(
      RetryMessageEvent event, Emitter<MentraChatState> emit) async {
    final MentraChatModel loadingMessage = event.message
      ..sendingState = SendingState.loading;
    allMessage
        .map((msg) => msg == event.message ? loadingMessage : msg)
        .toList();
    _addTyping();
    _scrollToLast();
    emit(const RetryMessageLoadingState());
    try {
      final response =
          await _repository.continueSession(sessionId, event.message.content);
      // emit(ContinueSessionSuccessState(response));

      allMessage = response.data.messages
          .where((element) => element.user != 'system')
          .map((e) => MentraChatModel.fromResponse(e))
          .toList();

      emit(MessageUpdatedState(allMessage));
      _scrollToLast();
    } catch (e) {
      _removeTyping();
      final updatedMessage = loadingMessage..sendingState = SendingState.failed;
      allMessage
          .map((msg) => msg == loadingMessage ? updatedMessage : msg)
          .toList();
      emit(ContinueSessionFailureState(e.toString()));
    }
  }
}
