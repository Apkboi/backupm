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
        answerType: AnswerType.TEXT,
        signupStage: SignupStage.YEAR,
        time: DateTime.now(),
        answerTime: DateTime.now()),
  ];
}
