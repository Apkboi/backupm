import 'package:flutter/material.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class BotChatmessageModel {
  String message;
  bool isFromBot;
  bool? showIcon;
  int id;
  bool? isTyping;
  AnswerType answerType;
  LoginStage loginStage;
  SignupStage signupStage;
  PasswordResetStage passwordResetStage;
  PermissionsStage permissionsStage;
  String? answer;
  DateTime time;
  DateTime? answerTime;
  Widget? child;
  Widget? answerWidget;
  BotChatFlow flow;

  BotChatmessageModel(
      {required this.message,
      required this.isFromBot,
      required this.id,
      this.isTyping = false,
      required this.answerType,
      this.loginStage = LoginStage.NONE,
      this.passwordResetStage = PasswordResetStage.NONE,
      this.permissionsStage = PermissionsStage.NONE,
      required this.time,
      this.answerTime,
      required this.flow,
      this.signupStage = SignupStage.NONE,
      this.answer,
      this.child,
      this.showIcon = true,
      this.answerWidget});

  factory BotChatmessageModel.botTyping() => BotChatmessageModel(
      message: '',
      isFromBot: true,
      id: 0,
      isTyping: true,
      answerType: AnswerType.NONE,
      loginStage: LoginStage.NONE,
      permissionsStage: PermissionsStage.NONE,
      answer: null,
      time: DateTime.now(),
      answerTime: DateTime.now(),
      signupStage: SignupStage.NONE,
      flow: BotChatFlow.welcome);
}

enum AnswerType {
  LOGIN_OPTION,
  WELCOME_OPTIONS,
  SIGNUP_OPTION,
  CHAT,
  USERNAME,
  EMAIL_PREVIW,
  LOGIN_PASSCODE,
  EMAIL,
  EMAIL_VERIFICATION,
  SELECTYEAR,
  CONFIRMPASSCODE,
  SET_PASSCODE,
  NUMBER,
  AVATAR,
  BIOMETRIC_OPTIONS,
  NOTIFICATION_OPTIONS,
  NONE,
}

enum LoginStage {
  NONE,
  INITIAL,
  EMAILPREVIEW,
  PASSWORD_RESET_SUCCESS,
  USERNAME,
  AVARTER,
  EMAIL,
  OTP,
  PASSCODE
}

enum PasswordResetStage {
  NONE,
  EMAIL,
  OTP,
  PASSCODE,
  CONFIRM_PASSCODE,
}

enum PermissionsStage { BIOMETRIC, NOTIFICATION, NONE }

enum SignupStage {
  NONE,
  EMAIL_VERIFICATION,
  EMAIL_MESSAGE,
  TERMS,
  USERNAME,
  AVARTER,
  YEAR,
  EMAIL,
  OTP,
  PASSCODE,
  PASSCODE_CONFIRM,
  SIGNUP_OPTION,
}

List<BotChatmessageModel> get testMessages {
  final List<String> messages = [
    'Hey Leila! I\'m Mentra, your friendly mental health buddy.',
    "How's your day going?",
    "Hi, Mentra! It's been a bit rough lately. Can you lend an ear?",
    "Absolutely! I'm here to listen and help. What's been bothering you?",
  ];

  final List<BotChatmessageModel> chatMessages = [];

  for (int i = 0; i < messages.length; i++) {
    chatMessages.add(
      BotChatmessageModel(
        message: messages[i],
        isFromBot: i.isEven,
        // Alternate between bot and user
        id: i,
        answerType: AnswerType.CHAT,
        time: DateTime.now().add(Duration(minutes: i)),
        // Simulate different timestamps
        flow: BotChatFlow
            .welcome, // Assuming all messages are part of the welcome flow
      ),
    );
  }

  return chatMessages;
}
