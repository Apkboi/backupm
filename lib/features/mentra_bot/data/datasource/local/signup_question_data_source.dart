import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';

class SignupQuestionDataSource {
  final List<BotChatmessageModel> questions = [
    BotChatmessageModel(
        message:
            'Verified! Thanks,${injector.get<RegistrationBloc>().registrationPayload.name}. Could you also tell me your year of birth for age verification?',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.SELECTYEAR,
        signupStage: SignupStage.YEAR,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Perfect! A verification code has just been sent to your email ${injector.get<RegistrationBloc>().registrationPayload.email}. Please enter the code here to continue.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.EMAIL_VERIFICATION,
        signupStage: SignupStage.EMAIL_VERIFICATION,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Perfect! A verification code has just been sent to your email ${injector.get<RegistrationBloc>().registrationPayload.email}. Please enter the code here to continue.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.EMAIL_VERIFICATION,
        signupStage: SignupStage.EMAIL_VERIFICATION,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Exciting! Let\'s get your new account set up. To start, what nickname or pseudonym would you like to use? This will be how you\'re identified within Mentra. (Remember, you can change this at any time',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.USERNAME,
        signupStage: SignupStage.USERNAME,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Appreciated! Let\'s secure your account. Please create a 4-digit passcode',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.SET_PASSCODE,
        signupStage: SignupStage.PASSCODE,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Appreciated! Let\'s secure your account. Please create a 4-digit passcode',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.SET_PASSCODE,
        signupStage: SignupStage.PASSCODE,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Well done! To ensure it\'s correct, please confirm your passcode.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.CONFIRMPASSCODE,
        signupStage: SignupStage.PASSCODE_CONFIRM,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Great choice, ${injector.get<RegistrationBloc>().registrationPayload.name}! Next, please choose an avatar that best represents you. We’re constantly adding more options to ensure you find the perfect match',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.AVATAR,
        signupStage: SignupStage.AVARTER,
        time: DateTime.now(),
        answerTime: DateTime.now()),
  ];
}
