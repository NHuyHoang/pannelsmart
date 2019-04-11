import 'package:panelsmart/models/answers/main.dart';
import 'package:panelsmart/models/questions/main.dart';
import 'package:panelsmart/models/questions/views/question_views.dart';

abstract class QuestionFactory {
  final Map<String, dynamic> rules;
  final QuestionType type;
  final String description;

  QuestionFactory({this.rules, this.type, this.description});

  Answer createAnswer();
  QuestionView createView(Question question);
}

class TextQuestionFactory implements QuestionFactory {
  final Map<String, dynamic> rules;
  final QuestionType type;
  final String description;

  TextQuestionFactory({this.rules, this.type, this.description}) : super();

  @override
  Answer createAnswer() => Answer.withRules(
        this.rules,
        this.type,
      );

  @override
  QuestionView createView(Question question) =>
      TextQuestionView(question: question);
}

class SingleSelectionQuestionFactory implements QuestionFactory {
  final Map<String, dynamic> rules;
  final QuestionType type;
  final List<String> selections;
  final String description;

  SingleSelectionQuestionFactory(
      {this.rules, this.type, this.selections, this.description})
      : super();

  @override
  Answer createAnswer() => Answer.withRules(
        this.rules,
        this.type,
        selections: this.selections,
      );

  @override
  QuestionView createView(Question question) {
    return null;
  }
}

class TextQuestions extends Question {
  TextQuestions({String id, String description})
      : super(id: id, description: description) {}
}
