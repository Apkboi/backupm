import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class PasswordResetDataSource {
  final List<BotChatmessageModel> messages = [
    BotChatmessageModel(
        message:
            'Resetting your password is easy. To get started, please provide the email address associated with your account.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.PASSWORD_RESET_EMAIL,
        passwordResetStage: PasswordResetStage.EMAIL,
        flow: BotChatFlow.passwordReset,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Thank you! 📧 We\'ve sent a one-time verification code to your email. Please check your email and enter the code here.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.PASSWORD_RESET_OTP,
        passwordResetStage: PasswordResetStage.OTP,
        flow: BotChatFlow.passwordReset,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Looking good! \nNow, let\'s create a secure passcode for your account. Please set up your passcode.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        flow: BotChatFlow.passwordReset,
        answerType: AnswerType.PASSWORD_RESET_PASSCODE,
        passwordResetStage: PasswordResetStage.PASSCODE,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:  'Well done! To ensure it\'s correct, please confirm your passcode.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        flow: BotChatFlow.passwordReset,
        answerType: AnswerType.PASSWORD_RESET_CONFIRMPASSCODE,
        passwordResetStage: PasswordResetStage.CONFIRM_PASSCODE,
        time: DateTime.now(),
        answerTime: DateTime.now()),


  ];
}
