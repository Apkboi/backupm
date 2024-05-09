import 'package:bloc/bloc.dart';
import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/sound/sound_manager.dart';
import 'package:mentra/features/settings/data/data_sources/preference_questions.dart';
import 'package:mentra/features/settings/data/models/change_therapist_stage.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/dormain/repository/user_preference_rpository.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/dormain/repository/therapy_repository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uuid/uuid.dart';

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

TherapyPreferenceIntent stringToTherapyPreferenceIntent(String value) {
  switch (value) {
    case 'changeTherapist':
      return TherapyPreferenceIntent.changeTherapist;
    case 'updatePreference':
      return TherapyPreferenceIntent.updatePreference;
    case 'selectTherapist':
      return TherapyPreferenceIntent.selectTherapist;
    default:
      throw ArgumentError('Invalid value: $value');
  }
}

class UserPreferenceCubit extends Cubit<UserPreferenceState> {
  final UserPreferenceRepository userPreferenceRepository;
  final TherapyRepository _therapyRepository;

  List<TherapyPreferenceMessageModel> stagedMessages = [];
  TherapyPreferenceMessageModel? currentQuestion;
  PreferenceQuestionsDataSource dataSource = PreferenceQuestionsDataSource();
  TherapyPreferenceIntent _chatIntent =
      TherapyPreferenceIntent.updatePreference;

  UserPreferenceCubit(this.userPreferenceRepository, this._therapyRepository)
      : super(UserPreferenceInitial());

  void startUpdatePreferenceMessage() async {
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

  void startChat(TherapyPreferenceIntent chatIntent) {
    _chatIntent = chatIntent;

    if (chatIntent == TherapyPreferenceIntent.updatePreference) {
      startUpdatePreferenceMessage();
    } else {
      startChangeTherapistChat();
    }
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
    if (stagedMessages.last.id == 7) {
      await Future.delayed(const Duration(milliseconds: 500));
      updatePreferences(convertQuestionsToMap(stagedMessages));

      // emit(QuestionsCompletedState());
    } else {
      emit(QuestionUpdatedState());
    }

    // _scrollToLast();

    SoundManager.playMessageReceivedSound();
  }

  void updateCurrentQuestion(TherapyPreferenceMessageModel question) {
    currentQuestion = question;
    emit(QuestionUpdatedState());
  }

  Map<String, dynamic> convertQuestionsToMap(
      List<TherapyPreferenceMessageModel> messages) {
    Map<String, dynamic> questionsMap = {};

    for (TherapyPreferenceMessageModel question in messages) {
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

      if (_chatIntent == TherapyPreferenceIntent.changeTherapist ||
          _chatIntent == TherapyPreferenceIntent.selectTherapist) {
        searchForTherapist(updatedPreference: true);
      } else {
        emit(UpdatePreferenceSuccessState(response));
      }
    } catch (e) {
      emit(UpdatePreferenceFailureState(e.toString()));
      rethrow;
    }

    // emit(UpdatePreferenceSuccessState(response));
//   emit(UpdatePreferenceFailureState(error))
  }

  void _addTyping() async {
    stagedMessages.add(TherapyPreferenceMessageModel.typing());
    currentQuestion = TherapyPreferenceMessageModel.typing();
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

  // ============================= Logic For Change Therapist =======================

  void answerChangeTherapistQuestion(
      {required dynamic id, required String answer}) {
    SoundManager.playMessageSentSound();
    //   Update the question with the answer
    stagedMessages.where((element) => element.id == id).first.answer = answer;
    stagedMessages.where((element) => element.id == id).first.answerTime =
        DateTime.now();

    currentQuestion = stagedMessages.last;

    emit(QuestionUpdatedState());
    getNextChangeTherapistQuestion();
  }

  getNextChangeTherapistQuestion() async {
    _addTyping();
    await Future.delayed(const Duration(seconds: 2));
    await _removeTyping();

    logger.w(currentQuestion?.answer);

    if (currentQuestion?.changeTherapistStage ==
        ChangeTherapistStage.updatePreferenceOption) {
      switch (currentQuestion?.answer) {
        case 'No, keep as it is':
          await searchForTherapist();
          break;
        case 'Yes, update my  preference':
          startUpdatePreferenceMessage();
          break;
      }

      if (currentQuestion?.changeTherapistStage ==
          ChangeTherapistStage.searchingForTherapist) {
        searchForTherapist();
      }
    }
    emit(QuestionUpdatedState());

    SoundManager.playMessageReceivedSound();
  }

  Future searchForTherapist({bool updatedPreference = false}) async {
    stagedMessages.add(
      TherapyPreferenceMessageModel(
        question: [
          'Give me a moment to find a therapist that matches your criteria.'
        ],
        therapyMessageType: TherapyMessageType.changeTherapistMessage,
        changeTherapistStage: ChangeTherapistStage.searchingForTherapist,
        answer: null,
        options: [],
        key: '0',
        id: const Uuid().v4(),
      ),
    );
    _addTyping();

    try {
      final response = await _therapyRepository.matchTherapist();

      stagedMessages.removeWhere((element) => element.isTyping == true);
      emit(QuestionUpdatedState());

      await Future.delayed(const Duration(milliseconds:500));
      stagedMessages.add(
        TherapyPreferenceMessageModel(
          question: [
            "Great news! I've found a therapist who matches your preferences. Their name is ${response.data.user.name}, ${_getSpecializations(response)} ${response.data.user.name} is a ${response.data.therapist.gender} therapist who speaks ${response.data.therapist.languagesSpoken.firstOrNull}."
          ],
          therapyMessageType: TherapyMessageType.changeTherapistMessage,
          changeTherapistStage: ChangeTherapistStage.foundTherapist,
          answer: null,
          options: [
            'View ${response.data.user.name}\'s profile',
          ],
          suggestedTherapist: response.data,
          key: '0',
          id: const Uuid().v4(),
        ),
      );

    }  catch (e) {
      logger.e(e.toString());
      // _removeTyping();
      stagedMessages.removeWhere((element) => element.isTyping == true);
      emit(QuestionUpdatedState());

      // stagedMessages.add(TherapyPreferenceMessageModel(
      //
      // ));

      emit(SearchTherapistFailedState());
    }


    // _removeTyping();
    emit(QuestionUpdatedState());
  }

  _getSpecializations(MatchTherapistResponse response) {
    if (response.data.therapist.techniquesOfExpertise.isNotEmpty) {
      return "and they specialize in ${(response.data.therapist.techniquesOfExpertise).firstOrNull}.";
    } else {
      return '';
    }
  }


  startChangeTherapistChat() async {
    for (var question in dataSource.changeTherapistStarter) {
      stagedMessages.clear();
      _addTyping();
      await Future.delayed(const Duration(seconds: 2));
      await _removeTyping();
      stagedMessages.add(question..questionTime = DateTime.now());
      currentQuestion = question;
      logger.i(stagedMessages.length);
      emit(QuestionUpdatedState());
    }
  }
}
