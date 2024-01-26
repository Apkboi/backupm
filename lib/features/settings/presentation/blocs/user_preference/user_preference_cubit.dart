import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/settings/data/data_sources/preference_questions.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'user_preference_state.dart';

class UserPreferenceCubit extends Cubit<UserPreferenceState> {
  List<QuestionPromptModel> stagedMessages = [];
  QuestionPromptModel? currentQuestion;
  PreferenceQuestionsDataSource dataSource = PreferenceQuestionsDataSource() ;

  UserPreferenceCubit() : super(UserPreferenceInitial());

  void startMessage() {
    stagedMessages.clear();
    stagedMessages.add(dataSource.therapyQuestions.first);
    currentQuestion = dataSource.therapyQuestions.first;
    logger.i(stagedMessages.length);
    emit(QuestionUpdatedState());
    // _scrollToLast();
  }

  final scrollController = ItemScrollController();

  void _scrollToLast() async {
    // emit(state.copyWith(highlightIndex: -1));

    await scrollController.scrollTo(
      alignment: 0.5,
      index: 0,
      curve: Curves.easeOut,
      duration: kTabScrollDuration,
    );

    // emit(state.copyWith(highlightIndex: event.index));
  }

  void answerQuestion({required int id, required String answer}) {
    //   Update the question with the answer
    stagedMessages.where((element) => element.id == id).first.answer = answer;

    //   Check if the answered question is the last question in the list to get next question
    if (id == stagedMessages.last.id) {
      //   Get NextQuestion
      getNextQuestion();
    } else {
      currentQuestion = stagedMessages.last;

      emit(QuestionUpdatedState());
    }
  }

  getNextQuestion() {
    // Check if questions are complete
    if (stagedMessages.length == dataSource.therapyQuestions.length) {
      emit(QuestionsCompletedState());
    } else {
      stagedMessages.add(dataSource.therapyQuestions[currentQuestion!.id + 1]);
      currentQuestion = stagedMessages.last;

      emit(QuestionUpdatedState());
      _scrollToLast();
    }
  }

  void updateCurrentQuestion(QuestionPromptModel question) {
    currentQuestion = question;
    emit(QuestionUpdatedState());
  }


}
