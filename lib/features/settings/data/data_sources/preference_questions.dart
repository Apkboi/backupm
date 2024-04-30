import 'package:mentra/features/settings/data/models/question_prompt_model.dart';

class PreferenceQuestionsDataSource {
  final List<QuestionPromptModel> therapyQuestions = [
    QuestionPromptModel(
      question: [
        "Let's personalize your experience. How are you feeling right now?"
      ],
      answer: null,
      options: [
        'Stressed',
        'Anxious',
        'Overwhelmed',
        'Depressed',
        'Content',
        'Curious'
      ],
      key: 'state_of_mind',
      id: 0,
    ),
    QuestionPromptModel(
      question: [
        'Understanding where you\'re at is important to us. Have you ever tried therapy or counseling before?'
      ],
      answer: null,
      options: ['Yes', 'No'],
      key: 'had_therapy',
      id: 1,
    ),
    QuestionPromptModel(
      question: [
        'Do you have any particular gender preference when it comes to discussing your feelings and thoughts?'
      ],
      answer: null,
      options: ["Male", "Female",'No preference'],
      key: 'gender',
      id: 2,
    ),
    QuestionPromptModel(
      question: ['Is there an age range you\'d prefer for your therapist?'],
      answer: null,
      options: [
        'Younger (20s-30s)',
        'Middle-aged (40s-50s)',
        'Older (60s+)',
        'No preference'
      ],
      key: 'age_range',
      id: 3,
    ),
    QuestionPromptModel(
      question: [
        'Are there any cultural or religious factors that you\'d like us to consider when assisting you?'
      ],
      answer: null,
      options: [],
      key: 'culture_factor',
      id: 4,
    ),
    QuestionPromptModel(
      question: [
        'Are there particular therapeutic approaches or techniques that resonate with you?'
      ],
      answer: null,
      options: [],
      key: 'therapeutic_approach',
      id: 5,
    ),
    QuestionPromptModel(
      question: [
        'Are there any specific areas or concerns you\'d like to address through your conversations?'
      ],
      answer: null,
      options: [],
      key: 'specific_concerns',
      id: 6,
    ),
    QuestionPromptModel(
      question: [
        'Your answers help us understand you better and ensure that we\'re well-equipped to provide the support you need.',
        'We\'re here to listen and assist with your well-being. 😊'
      ],
      answer: null,
      options: [],
      key: 'greeting',
      id: 7,
    ),
    // Add more questions as needed
  ];

  Map<String, dynamic> convertQuestionsToMap() {
    Map<String, dynamic> questionsMap = {};

    for (QuestionPromptModel question in therapyQuestions) {
      // Use the question key as the map key and the answer as the value
      questionsMap[question.key] = question.answer;
    }

    return questionsMap;
  }
}
