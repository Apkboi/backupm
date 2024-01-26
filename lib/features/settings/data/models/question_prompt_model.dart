class QuestionPromptModel {
  List question;
  String? answer;
  List options;
  String key;
  int id;

  QuestionPromptModel(
      {required this.question,
      this.answer,
      required this.options,
      required this.key,
      required this.id});
}
