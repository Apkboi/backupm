import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';

class BotChatmessageModel {
  String message;
  bool isFromBot;
  int id;
  bool? isTyping;
  AnswerType answerType;
  LoginStage loginStage;
  SignupStage signupStage;
  PermissionsStage permissionsStage;
  String? answer;
  DateTime time;
  DateTime? answerTime;
  BotChatFlow flow;

  BotChatmessageModel(
      {required this.message,
      required this.isFromBot,
      required this.id,
      this.isTyping = false,
      required this.answerType,
      this.loginStage = LoginStage.NONE,
      this.permissionsStage = PermissionsStage.NONE,
      required this.time,
      this.answerTime,
      required this.flow,
      this.signupStage = SignupStage.NONE,
      this.answer});

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
  USERNAME,
  AVARTER,
  EMAIL,
  OTP,
  PASSCODE
}

enum PermissionsStage { BIOMETRIC, NOTIFICATION, NONE }

enum SignupStage {
  NONE,
  EMAIL_VERIFICATION,
  USERNAME,
  AVARTER,
  YEAR,
  EMAIL,
  OTP,
  PASSCODE,
  PASSCODE_CONFIRM,
  SIGNUP_OPTION,
}
