import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';

class PreConversationDataSource {
  List<MentraChatModel> chatMessages = [
    MentraChatModel(
      stage: 1,
      content: "All set! How are you feeling right now?",
      isMentraMessage: true,
      time: DateTime.now(),
      options: [
        'Happy and optimistic',
        'Stressed or anxious',
        'Sad or down',
        'Just exploring'
      ],
    ),
    MentraChatModel(
      stage: 2,
      time: DateTime.now(),
      content:
          "Understanding where you're at is important to me. Have you ever tried therapy or counseling before?",
      isMentraMessage: true,
      options: ['Yes', 'No'],
    ),
    MentraChatModel(
      stage: 3,
      time: DateTime.now(),
      content:
          "Lastly, are there any specific areas you'd like to focus on in your well-being journey with me?",
      isMentraMessage: true,
      options: [
        'Managing anxiety or stress',
        'Improving mood',
        'Relationship issues',
        'Personal growth',
        'Other'
      ],
    ),
    MentraChatModel(
      stage: 4,
      time: DateTime.now(),
      content:
          "You’ve selected 'Other', could you tell me a bit more about what you're looking to focus on? OR Could you tell me more about your relationships/stress?",
      isMentraMessage: true,
    ),
    // Continue adding more chat messages as needed
  ];

  MentraChatModel? getNextQuestion(MentraChatModel? currentMessage,
      {String? answer}) {
    // Returns the first message
    if (currentMessage == null) {
      return chatMessages.first;
    }

    // Checks the third message answer to determine the next message
    if (currentMessage.stage == 3 &&
        answer.toString().toLowerCase() != 'other') {
      return null;
    }

    // In this case all messages have been exhausted
    if (currentMessage.stage == chatMessages.last.stage) {
      return null;
    }

    // Returning the next message
    return chatMessages
        .where((element) => element.stage == currentMessage.stage + 1)
        .first;
  }
}
