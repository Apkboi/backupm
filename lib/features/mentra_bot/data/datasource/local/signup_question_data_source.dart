import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

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
        flow: BotChatFlow.signup,
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
        flow: BotChatFlow.signup,
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Now, could you share your email address with us? We\'ll send a verification code to ensure that everything is secure.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        // child: RichText(
        //     text: TextSpan(
        //         style: GoogleFonts.plusJakartaSans(
        //             height: 1.5,
        //             color: Pallets.white,
        //             fontSize: 15.sp,
        //             fontWeight: FontWeight.w500),
        //         children: [
        //       const TextSpan(
        //           text:
        //               'Now, could you share your email address with us? We\'ll send a verification code to ensure that everything is secure,\n'),
        //       TextSpan(
        //           text: 'Terms and conditions ',
        //           recognizer: TapGestureRecognizer()
        //             ..onTap = () {
        //               Helpers.launchRawUrl(
        //                   'https://yourmentra.com/privacy-policy');
        //             },
        //           style: GoogleFonts.plusJakartaSans(
        //               color: Pallets.secondary, fontWeight: FontWeight.w600)),
        //       TextSpan(text: 'apply.', style: GoogleFonts.plusJakartaSans()),
        //     ])),
        answerType: AnswerType.EMAIL,
        signupStage: SignupStage.EMAIL,
        flow: BotChatFlow.signup,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Let\'s start with a nickname. This is how you\'ll be known in the Mentra community. Remember, you can change this at any time.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.USERNAME,
        signupStage: SignupStage.USERNAME,
        flow: BotChatFlow.signup,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Appreciated! Let\'s secure your account. Please create a 4-digit passcode.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.SET_PASSCODE,
        signupStage: SignupStage.PASSCODE,
        flow: BotChatFlow.signup,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Appreciated! Let\'s secure your account. Please create a 4-digit passcode.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.SET_PASSCODE,
        signupStage: SignupStage.PASSCODE,
        flow: BotChatFlow.signup,
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
        flow: BotChatFlow.signup,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Great choice, ${injector.get<RegistrationBloc>().registrationPayload.name}! Next, please choose an avatar that best represents you. We’re constantly adding more options to ensure you find the perfect match.',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.AVATAR,
        signupStage: SignupStage.AVARTER,
        flow: BotChatFlow.signup,
        time: DateTime.now(),
        answerTime: DateTime.now()),
    BotChatmessageModel(
        message:
            'Awesome choice, ${injector.get<RegistrationBloc>().registrationPayload.name} 🎉 Would you like to sign up using your email, Google, or Apple?',
        isFromBot: true,
        id: 0,
        isTyping: false,
        answerType: AnswerType.NONE,
        signupStage: SignupStage.EMAIL_MESSAGE,
        flow: BotChatFlow.signup,
        time: DateTime.now(),
        answerTime: DateTime.now()),
  ];
}
