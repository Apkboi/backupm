import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class LoginQuestionDataSource {
  final List<BotChatmessageModel> messages = [
    BotChatmessageModel(
        message: 'Hey there!',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.NONE,
        loginStage: LoginStage.NONE,
        flow: BotChatFlow.login,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Fantastic! Let\'s get you logged in.\nHow will you like to access your account.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.LOGIN_OPTION,
        loginStage: LoginStage.INITIAL,
        flow: BotChatFlow.login,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Success! Your password has been reset. You can now log in to your account using your new pin. Enter your email to proceed.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        flow: BotChatFlow.login,
        answerType: AnswerType.EMAIL_PREVIW,
        loginStage: LoginStage.PASSWORD_RESET_SUCCESS,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Fantastic! Let\'s get you logged in. Please provide your email.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        flow: BotChatFlow.login,
        answerType: AnswerType.EMAIL_PREVIW,
        loginStage: LoginStage.EMAILPREVIEW,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message: '',
        isFromBot: true,
        id: 0,
        isTyping: false,
        flow: BotChatFlow.login,
        answerType: AnswerType.EMAIL_PREVIW,
        loginStage: LoginStage.EMAILPREVIEW,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message: "Now, please enter your pin.",
        isFromBot: true,
        id: 0,
        isTyping: false,
        flow: BotChatFlow.login,
        answerType: AnswerType.LOGIN_PASSCODE,
        loginStage: LoginStage.PASSCODE,
        time: DateTime.now(),
        answerTime: DateTime.now()),
  ];
}
