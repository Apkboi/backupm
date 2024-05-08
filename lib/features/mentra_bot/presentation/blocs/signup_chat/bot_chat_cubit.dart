import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/sound/sound_manager.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/helper_utils.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/login_question_datasource.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/password_reset_datasource.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/permissions_message_data_source.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/signup_question_data_source.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/welcome_message_data_source.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_resend_otp_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

part 'bot_chat_state.dart';

enum BotChatFlow {
  welcome,
  signup,
  login,
  passwordReset,
  talkToMentra,
  permissions,
}

class BotChatCubit extends Cubit<BotChatState> {
  BotChatCubit() : super(BotChatInitial());
  List<BotChatmessageModel> stagedMessages = [];
  BotChatmessageModel? currentQuestion;
  LoginQuestionDataSource loginDataSource = LoginQuestionDataSource();
  SignupQuestionDataSource signupDataSource = SignupQuestionDataSource();
  PermissionMessageDataSource permissionsDataSource =
      PermissionMessageDataSource();
  PasswordResetDataSource passwordResetDataSource = PasswordResetDataSource();
  WelcomeMessageDataSource welcomeMessageDataSource =
      WelcomeMessageDataSource();
  BotChatFlow currentChatFlow = BotChatFlow.welcome;
  final scrollController = ItemScrollController();

  void startChat(BotChatFlow flow) async {
    stagedMessages.clear();
    var firstMessage = switch (flow) {
      BotChatFlow.welcome => BotChatmessageModel.botTyping(),
      BotChatFlow.signup => signupDataSource.questions.first
        ..time = DateTime.now(),
      BotChatFlow.login => loginDataSource.messages.first
        ..time = DateTime.now(),
      BotChatFlow.passwordReset => passwordResetDataSource.messages.first
        ..time = DateTime.now(),
      BotChatFlow.talkToMentra => BotChatmessageModel.botTyping(),
      BotChatFlow.permissions => permissionsDataSource.messages.first
        ..time = DateTime.now(),
    };

    // Simulating bot typing for welcome messages
    if (flow == BotChatFlow.welcome) {
      startWelcomeMessage();
    } else {
      await _simulateTyping();
      stagedMessages.add(firstMessage);
      currentQuestion = firstMessage;
      updateCurrentQuestion(firstMessage);
    }
  }

  Future<void> _simulateTyping() async {
    _addTyping();
    await Future.delayed(const Duration(seconds: 2));
    await _removeTyping();
  }

  void startWelcomeMessage() async {
    for (var message in welcomeMessageDataSource.messages) {
      _addTyping();
      await Future.delayed(const Duration(seconds: 2));
      await _removeTyping();
      await Future.delayed(const Duration(milliseconds: 300));
      stagedMessages.add(message..time = DateTime.now());
      currentQuestion = message;
      await SoundManager.playMessageReceivedSound();

      emit(QuestionUpdatedState());
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  // Determines if a message flow can be reverted back
  bool get canNotRevertMessages =>
      currentChatFlow == BotChatFlow.welcome ||
      currentChatFlow == BotChatFlow.talkToMentra ||
      (currentChatFlow == BotChatFlow.permissions &&
          currentQuestion!.permissionsStage == PermissionsStage.BIOMETRIC) ||
      (currentChatFlow == BotChatFlow.passwordReset &&
          currentQuestion!.passwordResetStage == PasswordResetStage.EMAIL);

  bool revertBack() {
    if (canNotRevertMessages) {
      return false;
    } else {
      stagedMessages.removeLast();
      stagedMessages.last.answer = null;
      if (stagedMessages.last.signupStage == SignupStage.EMAIL_MESSAGE ||
          stagedMessages.last.loginStage == LoginStage.PASSCODE) {
        revertBack();
      } else {
        updateCurrentQuestion(stagedMessages.last);
        _scrollToLast();
      }

      return true;
    }
  }

  void _scrollToLast() async {
    // TODO: REMOVE FUNCTION
  }

  void answerQuestion({
    required int id,
    required String answer,
    BotChatFlow? nextFlow,
    Widget? answerWidget,
    LoginStage? nextLoginStage,
    SignupStage? nextSignupStage,
    PermissionsStage? nextPermissionStage,
    PasswordResetStage? nextPasswordResetStage,
  }) async {
    // Update the question with the answer
    stagedMessages.last.answerWidget = answerWidget;
    stagedMessages.last.answer = answer;
    stagedMessages.last.answerTime = DateTime.now();
    SoundManager.playMessageSentSound();
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
        nextPasswordResetStage: nextPasswordResetStage,
        nextSignUpStage: nextSignupStage);
    _scrollToLast();
  }

  getNextQuestion({
    BotChatFlow? nextFlow,
    LoginStage? nextLoginStage,
    SignupStage? nextSignUpStage,
    PermissionsStage? nextPermissionStage,
    PasswordResetStage? nextPasswordResetStage,
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
        _getNextLoginMessage(nextLoginStage: nextLoginStage);
        break;

      case BotChatFlow.talkToMentra:
        _startMentraChat();
        break;
      case BotChatFlow.permissions:
        _getNextPermissionsMessage(nextPermissionStage: nextPermissionStage!);
      case BotChatFlow.passwordReset:
        _getNextPasswordResetQuestion(
            nextPasswordResetStage: nextPasswordResetStage);
    }
    SoundManager.playMessageReceivedSound();
  }

  void updateCurrentQuestion(BotChatmessageModel question) {
    currentChatFlow = question.flow;
    currentQuestion = question;
    emit(QuestionUpdatedState());
  }

  // =======================  Retreiving Next Login Question ================

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
    if (nextLoginStage == LoginStage.PASSCODE) {
      _addPasswordResetMessage();
    } else {
      updateCurrentQuestion(stagedMessages.last);
    }
    // emit(QuestionUpdatedState());
    _scrollToLast();
  }

  // =======================  Retrieving Next Signup Question ================

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
    } else if (nextSignupStage == SignupStage.EMAIL_VERIFICATION) {
      _addResendPassWordMessage();
    } else {
      updateCurrentQuestion(stagedMessages.last);
    }
  }

  // =======================  Retrieving Next PasswordReset Question ================

  void _getNextPasswordResetQuestion({
    PasswordResetStage? nextPasswordResetStage,
  }) {
    PasswordResetDataSource dataSource = PasswordResetDataSource();
    if (nextPasswordResetStage == null) {
      stagedMessages.add(dataSource.messages.first..time = DateTime.now());
    } else {
      stagedMessages.add(dataSource.messages
          .where(
              (element) => element.passwordResetStage == nextPasswordResetStage)
          .first
        ..time = DateTime.now());
      // CustomDialogs.showToast(stagedMessages.last.flow.name);
    }

    updateCurrentQuestion(stagedMessages.last);
  }

  void _addTyping() async {
    stagedMessages.add(BotChatmessageModel.botTyping());
    currentQuestion = BotChatmessageModel.botTyping();
    emit(QuestionUpdatedState());
    await Future.delayed(const Duration(seconds: 1));
  }

  Future _removeTyping() async {
    emit(RemoveTypingState());
    await Future.delayed(const Duration(milliseconds: 400));
    stagedMessages.removeWhere((element) => element.isTyping == true);
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
    _removeTyping();
    // stagedMessages.add(BotChatmessageModel.botTyping());
  }

  void _addTermsAndConditionMessage() async {
    var termsMessage = BotChatmessageModel(
        message: 'Terms and condition',
        isFromBot: true,
        id: 0,
        isTyping: false,
        child: HapticInkWell(
          onTap: () {
            Helpers.launchRawUrl('https://yourmentra.com/terms-and-conditions');
          },
          child: TextView(
              text: 'Terms and conditions apply',
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
    emit(QuestionUpdatedState());
  }

  void _addPasswordResetMessage() async {
    var termsMessage = BotChatmessageModel(
        message: 'Forgot pin?',
        isFromBot: true,
        id: 0,
        isTyping: false,
        child: HapticInkWell(
          onTap: () {
            answerQuestion(
              id: 0,
              answer: 'Forgot password',
              nextFlow: BotChatFlow.passwordReset,
            );

            // Helpers.launchRawUrl('https://yourmentra.com/terms-and-conditions');
          },
          child: RichText(
              text: TextSpan(
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      height: 1.5.h,
                      wordSpacing: 1.5,
                      color: Pallets.white
                      // letterSpacing: 2
                      ),
                  children: [
                TextSpan(
                    text: 'Forgot pin?',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: Pallets.secondary,
                      fontSize: 14.sp,
                      height: 1.5.h,
                      wordSpacing: 1.5,
                      decoration: TextDecoration.underline,
                      decorationColor: Pallets.secondary,
                      // letterSpacing: 2
                    ))
              ])),
        ),
        flow: BotChatFlow.login,
        answerType: AnswerType.LOGIN_PASSCODE,
        loginStage: LoginStage.PASSCODE,
        time: DateTime.now(),
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

  void _addResendPassWordMessage() async {
    var resendMessage = BotChatmessageModel(
        message: 'Resend Code',
        isFromBot: true,
        id: 0,
        isTyping: false,
        child: const BcResendOtpWidget(),
        flow: BotChatFlow.signup,
        answerType: AnswerType.EMAIL_VERIFICATION,
        signupStage: SignupStage.EMAIL_VERIFICATION,
        time: DateTime.now(),
        answerTime: DateTime.now());
    _addTyping();
    await Future.delayed(const Duration(seconds: 2));
    await _removeTyping();
    await Future.delayed(const Duration(milliseconds: 300));
    stagedMessages.add(resendMessage);
    currentQuestion = resendMessage;
    emit(QuestionUpdatedState());
  }
}
