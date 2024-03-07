import 'package:bloc/bloc.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/login_question_datasource.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/signup_question_data_source.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/welcome_message_data_source.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'bot_chat_state.dart';

enum BotChatFlow { welcome, signup, login, talkToMentra }

class BotChatCubit extends Cubit<BotChatState> {
  BotChatCubit() : super(BotChatInitial());
  List<BotChatmessageModel> stagedMessages = [];
  BotChatmessageModel? currentQuestion;
  LoginQuestionDataSource loginDataSource = LoginQuestionDataSource();
  SignupQuestionDataSource signupDataSource = SignupQuestionDataSource();
  WelcomeMessageDataSource welcomeMessageDataSource =
      WelcomeMessageDataSource();
  BotChatFlow currentChatFlow = BotChatFlow.welcome;

  void startMessage(BotChatFlow flow) async {
    if (flow != BotChatFlow.talkToMentra) {
      stagedMessages.clear();
      for (var message in welcomeMessageDataSource.messages) {
        _addTyping();
        await Future.delayed(const Duration(seconds: 2));
        _removeTyping();
        stagedMessages.add(message..time = DateTime.now());
        currentQuestion = message;
      }
      logger.i(stagedMessages.length);
      emit(QuestionUpdatedState());
    } else {}

    // _scrollToLast();
  }

  void revertBack() {}

  final scrollController = ItemScrollController();

  void _scrollToLast() async {
    // emit(state.copyWith(highlightIndex: -1));

    scrollController.jumpTo(
      alignment: 0.5,
      index: 0,

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
  }) {
    // Update the question with the answer
    stagedMessages.last.answer = answer;
    stagedMessages.last.answerTime = DateTime.now();
    logger.i(answer);

    getNextQuestion(
        nextFlow: nextFlow,
        nextLoginStage: nextLoginStage,
        nextSignUpStage: nextSignupStage);
  }

  getNextQuestion({
    BotChatFlow? nextFlow,
    LoginStage? nextLoginStage,
    SignupStage? nextSignUpStage,
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
        break;
    }
  }

  void updateCurrentQuestion(BotChatmessageModel question) {
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
      stagedMessages
          .add(signupDataSource.questions.first..time = DateTime.now());
    } else {
      stagedMessages.add(signupDataSource.questions
          .where((element) => element.signupStage == nextSignupStage)
          .first
        ..time = DateTime.now());
    }
    updateCurrentQuestion(stagedMessages.last);

    _scrollToLast();
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
}
