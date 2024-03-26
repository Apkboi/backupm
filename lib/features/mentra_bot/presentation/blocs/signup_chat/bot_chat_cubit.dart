import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/helper_utils.dart';
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

  void displayWelcomeMessages(BotChatFlow flow) async {
    if (flow != BotChatFlow.talkToMentra) {
      stagedMessages.clear();
      // _addTyping();
      for (var message in welcomeMessageDataSource.messages) {
        _addTyping();
        await Future.delayed(const Duration(seconds: 2));
        await _removeTyping();
        await Future.delayed(const Duration(milliseconds: 300));
        stagedMessages.add(message..time = DateTime.now());
        currentQuestion = message;
        emit(QuestionUpdatedState());
        logger.i(stagedMessages.length);
        await Future.delayed(const Duration(seconds: 1));
      }
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
      if (stagedMessages.last.signupStage == SignupStage.EMAIL_MESSAGE) {
        revertBack();
      } else {
        updateCurrentQuestion(stagedMessages.last);
        _scrollToLast();
      }

      return true;
    }
  }

  void _scrollToLast() async {
    // emit(state.copyWith(highlightIndex: -1));
    scrollController.scrollTo(
      alignment: 0.5,
      index: 0, duration: const Duration(milliseconds: 800),
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
    Widget? answerWidget,
    LoginStage? nextLoginStage,
    SignupStage? nextSignupStage,
    PermissionsStage? nextPermissionStage,
  }) async {
    // Update the question with the answer
    stagedMessages.last.answerWidget = answerWidget;
    stagedMessages.last.answer = answer;
    stagedMessages.last.answerTime = DateTime.now();
    emit(QuestionUpdatedState());
    await Future.delayed(const Duration(milliseconds: 300));
    _addTyping();
    _scrollToLast();
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        await _removeTyping();
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
    // CustomDialogs.showToast(question.flow.name);
    // CustomDialogs.showToast(question.message);

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
    SignupQuestionDataSource dataSource = SignupQuestionDataSource();
    if (nextSignupStage == null) {
      stagedMessages.add(dataSource.questions.first..time = DateTime.now());
    } else {
      stagedMessages.add(dataSource.questions
          .where((element) => element.signupStage == nextSignupStage)
          .first
        ..time = DateTime.now());
      // CustomDialogs.showToast(stagedMessages.last.flow.name);
    }

    if (nextSignupStage == SignupStage.EMAIL_MESSAGE) {
      _addTermsAndConditionMessage();
    } else {
      updateCurrentQuestion(stagedMessages.last);
    }

    // _scrollToLast();
  }

  void _addTyping() async {
    // await Future.delayed(const Duration(seconds: 1));
    stagedMessages.add(BotChatmessageModel.botTyping());
    currentQuestion = BotChatmessageModel.botTyping();
    emit(QuestionUpdatedState());
    await Future.delayed(const Duration(seconds: 1));
  }

  Future _removeTyping() async {
    emit(RemoveTypingState());
    await Future.delayed(const Duration(milliseconds: 400));
    stagedMessages.removeWhere((element) => element.isTyping == true);
    // await Future.delayed(const Duration(milliseconds: 300));
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

  void _addTermsAndConditionMessage() async {
    var termsMessage = BotChatmessageModel(
        message: 'Terms and condition',
        isFromBot: true,
        id: 0,
        isTyping: false,
        child: InkWell(
          onTap: () {
            Helpers.launchRawUrl('https://yourmentra.com/terms-and-conditions');
          },
          child: TextView(
              text: 'Terms and conditions apply',
              // color: Pallets.secondary,
              // fontWeight: FontWeight.w600,
              // lineHeight: 1.5,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: Pallets.secondary,
                fontSize: 15,
                height: 1.5.h,

                wordSpacing: 1.5,
                decoration: TextDecoration.underline,
                decorationColor: Pallets.secondary,
                // letterSpacing: 2
              )),
        ),
        answerType: AnswerType.SIGNUP_OPTION,
        signupStage: SignupStage.TERMS,
        time: DateTime.now(),
        flow: BotChatFlow.signup,
        answerTime: DateTime.now());

    _addTyping();
    await Future.delayed(const Duration(seconds: 2));
    await _removeTyping();
    await Future.delayed(const Duration(milliseconds: 300));
    stagedMessages.add(termsMessage);
    currentQuestion = termsMessage;
    // updateCurrentQuestion(termsMessage);
    emit(QuestionUpdatedState());
  }
}
