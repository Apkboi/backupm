import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/login_question_datasource.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/signup_question_data_source.dart';
import 'package:mentra/features/mentra_bot/data/datasource/local/welcome_message_data_source.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'bot_chat_state.dart';

enum BotChatFlow { welcome, signup, login }

class BotChatCubit extends Cubit<BotChatState> {
  BotChatCubit() : super(BotChatInitial());
  List<BotChatModel> stagedMessages = [];
  BotChatModel? currentQuestion;
  LoginQuestionDataSource loginDataSource = LoginQuestionDataSource();
  SignupQuestionDataSource signupDataSource = SignupQuestionDataSource();
  WelcomeMessageDataSource welcomeMessageDataSource =
      WelcomeMessageDataSource();

  void startMessage() {
    stagedMessages.clear();
    stagedMessages
        .add(welcomeMessageDataSource.questions.first..time = DateTime.now());
    currentQuestion = welcomeMessageDataSource.questions.first;
    logger.i(stagedMessages.length);
    emit(QuestionUpdatedState());
    // _scrollToLast();
  }

  void revertBack() {}

  final scrollController = ItemScrollController();

  void _scrollToLast() async {
    // emit(state.copyWith(highlightIndex: -1));

    scrollController.jumpTo(
      alignment: 0.5,
      index: 0,

      // curve: Curves.easeOut,
      // duration: kTabScrollDuration,
    );

    // emit(state.copyWith(highlightIndex: event.index));
  }

  void answerQuestion({required int id, required String answer}) {
    //   Update the question with the answer

    // stagedMessages.where((element) => element.id == id).first.answer = answer;
    // stagedMessages.where((element) => element.id == id).first.answerTime =
    //     DateTime.now();
    // //   Check if the answered question is the last question in the list to get next question
    // if (id == stagedMessages.last.id) {
    //   //   Get NextQuestion
    //   getNextQuestion();
    // } else {
    //   currentQuestion = stagedMessages.last;
    //   if (stagedMessages.length == loginDataSource.therapyQuestions.length) {
    //     // emit(QuestionsCompletedState());
    //   } else {
    //     emit(QuestionUpdatedState());
    //   }
    // }

  }

  getNextQuestion() {

    // stagedMessages.add(loginDataSource.therapyQuestions[currentQuestion!.id + 1]
    //   ..questionTime = DateTime.now());
    // currentQuestion = stagedMessages.last;
    // // Check if questions are complete
    // if (stagedMessages.length == loginDataSource.therapyQuestions.length) {
    //   emit(QuestionsCompletedState());
    // } else {
    //   emit(QuestionUpdatedState());
    // }
    // _scrollToLast();

  }

  void updateCurrentQuestion(BotChatModel question) {
    currentQuestion = question;
    emit(QuestionUpdatedState());
  }

  void _getNextLoginMessage() {}

  void _getNextSignupMessage() {}
}
