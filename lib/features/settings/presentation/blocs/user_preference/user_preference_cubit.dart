import 'package:bloc/bloc.dart';
import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/sound/sound_manager.dart';
import 'package:mentra/features/settings/data/data_sources/preference_questions.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/dormain/repository/user_preference_rpository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'user_preference_state.dart';

enum UserPreferenceFlow {
  signup,
  changeTherapist,
  updatePreference,
  selectTherapist
}

UserPreferenceFlow stringToUserPreferenceFlow(String value) {
  switch (value) {
    case 'signup':
      return UserPreferenceFlow.signup;
    case 'changeTherapist':
      return UserPreferenceFlow.changeTherapist;
    case 'updatePreference':
      return UserPreferenceFlow.updatePreference;
    case 'selectTherapist':
      return UserPreferenceFlow.selectTherapist;
    default:
      throw ArgumentError('Invalid value: $value');
  }
}

class UserPreferenceCubit extends Cubit<UserPreferenceState> {
  final UserPreferenceRepository userPreferenceRepository;
  List<QuestionPromptModel> stagedMessages = [];
  QuestionPromptModel? currentQuestion;
  PreferenceQuestionsDataSource dataSource = PreferenceQuestionsDataSource();

  UserPreferenceCubit(this.userPreferenceRepository)
      : super(UserPreferenceInitial());

  void startMessage() async {
    stagedMessages.clear();
    _addTyping();
    await Future.delayed(const Duration(seconds: 2));
    await _removeTyping();
    stagedMessages
        .add(dataSource.therapyQuestions.first..questionTime = DateTime.now());
    currentQuestion = dataSource.therapyQuestions.first;
    logger.i(stagedMessages.length);
    emit(QuestionUpdatedState());
    // _scrollToLast();
  }

  final scrollController = ItemScrollController();

  void _scrollToLast() async {
    // emit(state.copyWith(highlightIndex: -1));
    // scrollController.jumpTo(
    //   alignment: 0.5,
    //   index: 0,
    //   // curve: Curves.easeOut,
    //   // duration: kTabScrollDuration,
    // );

    // emit(state.copyWith(highlightIndex: event.index));x
  }

  void answerQuestion({required int id, required String answer}) {
    SoundManager.playMessageSentSound();

    //   Update the question with the answer
    stagedMessages.where((element) => element.id == id).first.answer = answer;
    stagedMessages.where((element) => element.id == id).first.answerTime =
        DateTime.now();

    emit(QuestionUpdatedState());
    //   Check if the answered question is the last question in the list to get next question
    if (id == stagedMessages.last.id) {
      //   Get NextQuestion
      getNextQuestion();
    } else {
      currentQuestion = stagedMessages.last;
      if (stagedMessages.length == dataSource.therapyQuestions.length) {
        emit(QuestionsCompletedState());
      } else {
        emit(QuestionUpdatedState());
      }
    }
  }

  getNextQuestion() async {
    _addTyping();
    await Future.delayed(const Duration(seconds: 2));
    await _removeTyping();

    stagedMessages.add(dataSource.therapyQuestions[currentQuestion!.id + 1]
      ..questionTime = DateTime.now());
    currentQuestion = stagedMessages.last;
    // Check if questions are complete
    if (stagedMessages.length == dataSource.therapyQuestions.length) {
      await Future.delayed(const Duration(milliseconds: 500));
      updatePreferences(convertQuestionsToMap(stagedMessages));

      // emit(QuestionsCompletedState());
    } else {
      emit(QuestionUpdatedState());
    }

    _scrollToLast();

    SoundManager.playMessageReceivedSound();
  }

  void updateCurrentQuestion(QuestionPromptModel question) {
    currentQuestion = question;
    emit(QuestionUpdatedState());
  }

  Map<String, dynamic> convertQuestionsToMap(
      List<QuestionPromptModel> messages) {
    Map<String, dynamic> questionsMap = {};

    for (QuestionPromptModel question in messages) {
      // Use the question key as the map key and the answer as the value
      if (question.key == 'age_range') {
        questionsMap[question.key] = agePreferenceMap[question.answer];
      } else {
        questionsMap[question.key] = question.answer;
      }
    }

    logger.i(questionsMap);

    return questionsMap;
  }

  void updatePreferences(Map<String, dynamic> preferences) async {
    try {
      emit(UpdatePreferenceLoadingState());

      final response = await userPreferenceRepository.updatePreferences(
          preferences: preferences);

      emit(UpdatePreferenceSuccessState(response));
    } catch (e) {
      emit(UpdatePreferenceFailureState(e.toString()));
      rethrow;
    }

    // emit(UpdatePreferenceSuccessState(response));
//   emit(UpdatePreferenceFailureState(error))
  }

  void _addTyping() async {
    stagedMessages.add(QuestionPromptModel.typing());
    currentQuestion = QuestionPromptModel.typing();
    emit(QuestionUpdatedState());
    await Future.delayed(const Duration(seconds: 1));
  }

  Future _removeTyping() async {
    emit(RemoveTypingState());
    await Future.delayed(const Duration(milliseconds: 400));
    stagedMessages.removeWhere((element) => element.isTyping == true);
    currentQuestion = stagedMessages.lastOrNull;
  }

  final agePreferenceMap = {
    'Younger (20s-30s)': '20-30',
    'Middle-aged (40s-50s)': '40-50',
    'Older (60s+)': '60 -100',
    'No preference': '0-100'
  };
}
