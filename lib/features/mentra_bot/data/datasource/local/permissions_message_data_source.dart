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
        permissionsStage: PermissionsStage.BIOMETRIC,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Cool beans! 😎 We\'re almost there. Can we send you friendly notifications to brighten your day?',
        isFromBot: true,
        id: 1,
        isTyping: false,
        flow: BotChatFlow.permissions,
        answerType: AnswerType.NOTIFICATION_OPTIONS,
        loginStage: LoginStage.NONE,
        permissionsStage: PermissionsStage.NOTIFICATION,
        time: DateTime.now(),
        answerTime: DateTime.now()),
  ];
}
