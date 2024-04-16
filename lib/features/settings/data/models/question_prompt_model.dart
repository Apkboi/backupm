class QuestionPromptModel {
  List question;
  String? answer;
  List options;
  String key;
  int id;
  bool isTyping;
  DateTime? questionTime = DateTime.now();
  DateTime? answerTime = DateTime.now();

  QuestionPromptModel(
      {required this.question,
      this.answer,
      // this.questionTime,
      this.isTyping = false,
      required this.options,
      required this.key,
      required this.id});

  factory QuestionPromptModel.typing() => QuestionPromptModel(
      question: [], options: [], key: '', id: 200, isTyping: true);
}
