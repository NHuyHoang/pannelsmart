import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

enum QuestionType { TEXT, SINGLE_SELECTIONS }

class Question {
  final String id;
  final String description;
  final QuestionView questionView;
  final Answer answer;

  Question({
    @required this.id,
    this.description,
    this.questionView,
    this.answer,
  });

  factory Question.jsonFactory(Map<String, String> json) {
    if (json['id'] == null)
      throw new Exception('An id is required for question');
    var id = json['id'];
    if (json['type'] == null)
      throw new Exception('Question $id, An type is required for question');

    String _type = json['type'];
    QuestionFactory _factory;
    switch (_type) {
      case "TEXT":
      case "SINGLE_SELECTIONS":
      default:
        _factory = TextQuestionFactory(true);
        break;
    }

    return Question(
      questionView: _factory.createView(),
      id: id,
      description: json['description'] ?? "",
      answer: _factory.createAnswer(),
    );
  }

  QuestionType _getType(String type) {
    switch (type) {
      case "TEXT":
        return QuestionType.TEXT;
      case "SINGLE_SELECTIONS":
        return QuestionType.SINGLE_SELECTIONS;
      default:
        return QuestionType.TEXT;
    }
  }
}

abstract class QuestionFactory {
  final bool rules;
  QuestionFactory(this.rules);

  Answer createAnswer();
  QuestionView createView();
}

class TextQuestionFactory implements QuestionFactory {
  bool rules;
  TextQuestionFactory(bool rules) : super();

  @override
  Answer createAnswer() {
    // TODO: implement createAnswer
    return null;
  }

  @override
  QuestionView createView() {
    // TODO: implement createView
    return null;
  }
}

class TextQuestions extends Question {
  TextQuestions({String id, String description})
      : super(id: id, description: description) {}
}

abstract class Answer {
  String answerText;
  Answer();

  bool validate();
}

abstract class QuestionView {
  Widget anserView;
  Widget infoView;
}

class TextAnswer implements Answer {
  @override
  String answerText;

  @override
  bool validate() => true;
}
