class QuestionPromptModel {
  List question;
  String? answer;
  List options;
  String key;
  int id;
  DateTime? questionTime = DateTime.now();
  DateTime? answerTime = DateTime.now();

  QuestionPromptModel(
      {required this.question,
      this.answer,
      // this.questionTime,
      // this.answerTime,
      required this.options,
      required this.key,
      required this.id});
}
