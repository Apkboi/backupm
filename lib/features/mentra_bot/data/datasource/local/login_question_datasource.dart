import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';

class LoginQuestionDataSource {
  final List<BotChatmessageModel> messages = [
    BotChatmessageModel(
        message: 'Hey there!',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.NONE,
        loginStage: LoginStage.NONE,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message: 'Hey there!\nHow will you like to access your account',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.LOGIN_OPTION,
        loginStage: LoginStage.INITIAL,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message: 'Fantastic! Let\'s get you logged in. Please provide your email.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.TEXT,
        loginStage: LoginStage.EMAILPREVIEW,
        time: DateTime.now(),
        answerTime: DateTime.now()),

  ];
}
