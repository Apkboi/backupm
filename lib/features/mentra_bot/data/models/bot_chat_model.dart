class BotChatModel {
  String message;
  bool isFromBot;
  String id;
  bool? isTyping;
  AnswerType answerType;
  MessageType messageType;
  String? answer;
  DateTime time;

  BotChatModel(
      {required this.message,
      required this.isFromBot,
      required this.id,
      this.isTyping = false,
      required this.answerType,
      required this.messageType,
      required this.time,
      this.answer});

  factory BotChatModel.botTyping() => BotChatModel(
      message: '',
      isFromBot: true,
      id: '',
      isTyping: true,
      answerType: AnswerType.NONE,
      messageType: MessageType.Test,
      answer: null,
      time: DateTime.now());
}

enum AnswerType {
  LOGIN_OPTION,
  WELCOME_OPTIONS,
  SIGNUP_OPTION,
  TEXT,
  NUMBER,
  AVATAR,
  ACTION_OPTION,
  NONE,
}

enum MessageType { Test }
