import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';

class PermissionMessageDataSource {
  List<BotChatmessageModel> messages = [
    BotChatmessageModel(
        message:
        'Strong passcode! Would you like to enable Face ID for even quicker access?',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.BIOMETRIC_OPTIONS,
        loginStage: LoginStage.NONE,
        flow: BotChatFlow.permissions,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Your privacy is a big deal for me. Every chat here is private and anonymous, meaning you can truly be yourself without any worries.\nYour data? It’s yours and yours alone – safe, secure, and respected.',
        isFromBot: true,
        id: 1,
        isTyping: false,
        flow: BotChatFlow.permissions,
        answerType: AnswerType.NONE,
        loginStage: LoginStage.NONE,
        time: DateTime.now(),
        answerTime: DateTime.now()),
  ];
}
