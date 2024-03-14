import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/login_question_datasource.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/permissions_message_data_source.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/signup_question_data_source.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/welcome_message_data_source.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'bot_chat_state.dart';

enum BotChatFlow {
  welcome,
  signup,
  login,
  talkToMentra,
  permissions,
}

class BotChatCubit extends Cubit<BotChatState> {
  BotChatCubit() : super(BotChatInitial());
  List<BotChatmessageModel> stagedMessages = [];
  BotChatmessageModel? currentQuestion;
  LoginQuestionDataSource loginDataSource = LoginQuestionDataSource();
  SignupQuestionDataSource signupDataSource = SignupQuestionDataSource();
  WelcomeMessageDataSource welcomeMessageDataSource =
      WelcomeMessageDataSource();
  BotChatFlow currentChatFlow = BotChatFlow.welcome;
  final scrollController = ItemScrollController();

  void startMessage(BotChatFlow flow) async {
    if (flow != BotChatFlow.talkToMentra) {
      stagedMessages.clear();
      for (var message in welcomeMessageDataSource.messages) {
        _addTyping();
        await Future.delayed(const Duration(seconds: 1));
        _removeTyping();
        stagedMessages.add(message..time = DateTime.now());
        currentQuestion = message;
      }
      logger.i(stagedMessages.length);
      emit(QuestionUpdatedState());
    } else {}
  }

  bool get canNotRevert =>
      currentChatFlow == BotChatFlow.welcome ||
      currentChatFlow == BotChatFlow.talkToMentra ||
      (currentChatFlow == BotChatFlow.permissions &&
          currentQuestion!.permissionsStage == PermissionsStage.BIOMETRIC);

  bool revertBack() {
    if (canNotRevert) {
      return false;
    } else {
      stagedMessages.removeLast();
      stagedMessages.last.answer = null;

      updateCurrentQuestion(stagedMessages.last);
      _scrollToLast();
      return true;
    }
  }

  void _scrollToLast() async {
    // emit(state.copyWith(highlightIndex: -1));
    scrollController.scrollTo(
      alignment: 0.5,
      index: stagedMessages.length, duration: const Duration(microseconds: 1),
      curve: Curves.easeInOut,
      // curve: Curves.easeOut,
      // duration: kTabScrollDuration,
    );

    // emit(state.copyWith(highlightIndex: event.index));
  }

  void answerQuestion({
    required int id,
    required String answer,
    BotChatFlow? nextFlow,
    LoginStage? nextLoginStage,
    SignupStage? nextSignupStage,
    PermissionsStage? nextPermissionStage,
  }) async {
    // Update the question with the answer
    stagedMessages.last.answer = answer;
    stagedMessages.last.answerTime = DateTime.now();
    logger.i(answer);
    emit(QuestionUpdatedState());
    await Future.delayed(const Duration(milliseconds: 500));
    _addTyping();
    _scrollToLast();

    await Future.delayed(
      const Duration(seconds: 1),
      () {
        _removeTyping();
      },
    );
    getNextQuestion(
        nextFlow: nextFlow,
        nextLoginStage: nextLoginStage,
        nextPermissionStage: nextPermissionStage,
        nextSignUpStage: nextSignupStage);
    _scrollToLast();
  }

  getNextQuestion({
    BotChatFlow? nextFlow,
    LoginStage? nextLoginStage,
    SignupStage? nextSignUpStage,
    PermissionsStage? nextPermissionStage,
  }) {
    logger.i(currentChatFlow.name);

    if (nextFlow != null) {
      currentChatFlow = nextFlow;
    }
    switch (currentChatFlow) {
      case BotChatFlow.welcome:
        break;
      case BotChatFlow.signup:
        _getNextSignupMessage(nextSignupStage: nextSignUpStage);
        break;

      case BotChatFlow.login:
        logger.i('IN login stage');
        _getNextLoginMessage(nextLoginStage: nextLoginStage);
        break;

      case BotChatFlow.talkToMentra:
        _startMentraChat();
        break;
      case BotChatFlow.permissions:
        _getNextPermissionsMessage(nextPermissionStage: nextPermissionStage!);
    }
  }

  void updateCurrentQuestion(BotChatmessageModel question) {
    currentChatFlow = question.flow;
    currentQuestion = question;
    emit(QuestionUpdatedState());
  }

  void _getNextLoginMessage({
    LoginStage? nextLoginStage,
  }) {
    logger.i('IN login stage');
    if (nextLoginStage == null) {
      stagedMessages.add(loginDataSource.messages.first..time = DateTime.now());
    } else {
      stagedMessages.add(loginDataSource.messages
          .where((element) => element.loginStage == nextLoginStage)
          .first
        ..time = DateTime.now());
    }
    updateCurrentQuestion(stagedMessages.last);
    // emit(QuestionUpdatedState());
    _scrollToLast();
  }

  void _getNextSignupMessage({
    SignupStage? nextSignupStage,
  }) {
    logger.i('IN login stage');
    SignupQuestionDataSource dataSource = SignupQuestionDataSource();
    if (nextSignupStage == null) {
      stagedMessages.add(dataSource.questions.first..time = DateTime.now());
    } else {
      stagedMessages.add(dataSource.questions
          .where((element) => element.signupStage == nextSignupStage)
          .first
        ..time = DateTime.now());
    }
    updateCurrentQuestion(stagedMessages.last);

    // _scrollToLast();
  }

  void _addTyping() {
    stagedMessages.add(BotChatmessageModel.botTyping());
    currentQuestion = BotChatmessageModel.botTyping();
    emit(QuestionUpdatedState());
  }

  void _removeTyping() {
    stagedMessages.removeWhere((element) => element.isTyping == true);
    emit(QuestionUpdatedState());
  }

  void _getNextPermissionsMessage(
      {required PermissionsStage nextPermissionStage}) {
    PermissionMessageDataSource dataSource = PermissionMessageDataSource();

    stagedMessages.add(dataSource.messages
        .where((element) => element.permissionsStage == nextPermissionStage)
        .first
      ..time = DateTime.now());

    updateCurrentQuestion(stagedMessages.last);
  }

  void _startMentraChat() {
    // stagedMessages.add(BotChatmessageModel.botTyping());
  }
}
