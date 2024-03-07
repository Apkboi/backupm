class BotChatmessageModel {
  String message;
  bool isFromBot;
  int id;
  bool? isTyping;
  AnswerType answerType;
  LoginStage loginStage;
  SignupStage signupStage;
  String? answer;
  DateTime time;
  DateTime? answerTime;

  BotChatmessageModel(
      {required this.message,
      required this.isFromBot,
      required this.id,
      this.isTyping = false,
      required this.answerType,
      this.loginStage = LoginStage.NONE,
      required this.time,
      this.answerTime,
      this.signupStage = SignupStage.NONE,
      this.answer});

  factory BotChatmessageModel.botTyping() => BotChatmessageModel(
      message: '',
      isFromBot: true,
      id: 0,
      isTyping: true,
      answerType: AnswerType.NONE,
      loginStage: LoginStage.NONE,
      answer: null,
      time: DateTime.now(),
      answerTime: DateTime.now(),
      signupStage: SignupStage.NONE);
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
  ACTION_OPTION,
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
}
