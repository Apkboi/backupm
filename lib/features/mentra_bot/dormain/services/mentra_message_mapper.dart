import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';

class MentraMessageMapper {
static  List<MentraChatModel> authMessagesToMentraMessages(
      List<BotChatmessageModel> authMessage) {
    List<MentraChatModel> mappedMessages = [];

    for (var message in authMessage) {
      mappedMessages.add(MentraChatModel.fromBotChatMessage(message));
      if (message.answer != null) {
        mappedMessages.add(MentraChatModel.fromBotChatMessage(message
          ..isFromBot = false
          ..message = message.answer!));
      }
    }

    return mappedMessages;
  }
}
