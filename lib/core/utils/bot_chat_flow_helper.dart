import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class BotChatFlowHelper {
  String toStringValue() {
    switch (this) {
      case BotChatFlow.welcome:
        return 'welcome';
      case BotChatFlow.signup:
        return 'signup';
      case BotChatFlow.login:
        return 'login';
      case BotChatFlow.passwordReset:
        return 'passwordReset';
      case BotChatFlow.talkToMentra:
        return 'talkToMentra';
      case BotChatFlow.permissions:
        return 'permissions';
      default:
        return 'welcome';
    }
  }

  static BotChatFlow fromStringValue(String value) {
    switch (value) {
      case 'welcome':
        return BotChatFlow.welcome;
      case 'signup':
        return BotChatFlow.signup;
      case 'login':
        return BotChatFlow.login;
      case 'passwordReset':
        return BotChatFlow.passwordReset;
      case 'talkToMentra':
        return BotChatFlow.talkToMentra;
      case 'permissions':
        return BotChatFlow.permissions;
      default:
        throw ArgumentError('Invalid BotChatFlow string value: $value');
    }
  }
}
