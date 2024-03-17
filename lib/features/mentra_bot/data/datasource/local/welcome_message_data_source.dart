import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';

class WelcomeMessageDataSource {
  var now = DateTime.now();
  List<BotChatmessageModel> messages = [
    BotChatmessageModel(
        message:
            '🎉 Welcome! It\'s wonderful to have you on board. I’m Mentra, your 24/7 emotional and mental well-being buddy, tailored just for you',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.NONE,
        loginStage: LoginStage.NONE,
        time:  DateTime.now(),
        flow: BotChatFlow.welcome,
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Your privacy is a big deal for me. Every chat here is private and anonymous, meaning you can truly be yourself without any worries.\nYour data? It’s yours and yours alone – safe, secure, and respected.',
        isFromBot: true,
        id: 1,
        isTyping: false,
        answerType: AnswerType.NONE,
        loginStage: LoginStage.NONE,
        flow: BotChatFlow.welcome,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Before we proceed, do you already have a Mentra account, or would you like to create a new one ?',
        isFromBot: true,
        id: 2,
        isTyping: false,
        answerType: AnswerType.WELCOME_OPTIONS,
        loginStage: LoginStage.NONE,
        time: DateTime.now(),
        flow: BotChatFlow.welcome,
        answerTime: DateTime.now()),

    // BotChatmessageModel(
    //     message:
    //         'Before we proceed, do you already have a Mentra account, or would you like to create a new one ?',
    //     isFromBot: true,
    //     id: 2,
    //     isTyping: false,
    //     answerType: AnswerType.WELCOME_OPTIONS,
    //     loginStage: LoginStage.NONE,
    //     time: DateTime.now(),
    //     answerTime: DateTime.now()),
    // BotChatmessageModel(
    //   message: 'Please select a sign-in option:',
    //   isFromBot: true,
    //   id: '2',
    //   isTyping: false,
    //   answerType: AnswerType.LOGIN_OPTION,
    //   messageType: MessageType.Test,
    //   time: DateTime.now(),
    // ),
    // Add more messages as needed
  ];
}
