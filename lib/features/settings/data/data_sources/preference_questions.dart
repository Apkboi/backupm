import 'package:mentra/features/settings/data/models/question_prompt_model.dart';

class PreferenceQuestionsDataSource {

  final List<QuestionPromptModel> therapyQuestions = [
    QuestionPromptModel(
      question: ['How would you describe your current mood?'],
      answer: null,
      options: ['Happy', 'Sad', 'Neutral', 'Stressed', 'Excited'],
      key: 'current_mood',
      id: 0,
    ),
    QuestionPromptModel(
      question: ['Do you have any specific goals for therapy?'],
      answer: null,
      options: ['Yes', 'No'],
      key: 'therapy_goals',
      id: 1,
    ),
    QuestionPromptModel(
      question: ['What activities bring you joy?'],
      answer: null,
      options: [],
      key: 'joyful_activities',
      id: 2,
    ),
    QuestionPromptModel(
      question: ['How would you rate your stress level right now?'],
      answer: null,
      options: ['Low', 'Moderate', 'High'],
      key: 'stress_level',
      id: 3,
    ),
    QuestionPromptModel(
      question: ['Are you experiencing any specific challenges?'],
      answer: null,
      options: [],
      key: 'specific_challenges',
      id: 4,
    ),
    // Add more questions as needed
  ];

}
