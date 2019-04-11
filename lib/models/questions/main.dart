import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:panelsmart/models/answers/main.dart';
import 'package:panelsmart/models/questions/factory.dart';
import 'package:panelsmart/models/questions/views/question_views.dart';

enum QuestionType { TEXT, SINGLE_SELECTIONS }

class Question {
  final String id;
  final String description;
  Map<String,dynamic> rules;
  QuestionView questionView;
  QuestionType type;
  Answer answer;

  Question({
    @required this.id,
    this.description,
    //this.questionView,
    this.answer,
  });

  factory Question.jsonFactory(Map<String, dynamic> json) {
    if (json['id'] == null)
      throw new Exception('An id is required for question');
    var id = json['id'];
    if (json['type'] == null)
      throw new QuestionException(
          'Question $id, An type is required for question');

    var rules = json['rule'];
    String _type = json['type'];
    QuestionFactory _factory = _getQuestionFactory(
      type: _type,
      rules: rules,
      description: json['description'] ?? "",
      selections: json['selections'],
    );
    
    Question question = Question(
      id: id,
      description: json['description'] ?? "",
      answer: _factory.createAnswer(),
    );

    question.questionView = _factory.createView(question);
    return question;

    // return Question(
    //   //questionView: _factory.createView(),
    //   id: id,
    //   description: json['description'] ?? "",
    //   answer: _factory.createAnswer(),

    // )..questionView = QuestionView(self);
  }
}

QuestionFactory _getQuestionFactory(
    {@required String type,
    String description,
    Map<String, dynamic> rules,
    List<String> selections}) {
  switch (type) {
    case "SINGLE_SELECTIONS":
      return SingleSelectionQuestionFactory(
        rules: rules,
        type: QuestionType.SINGLE_SELECTIONS,
        selections: selections,
      );
    case "TEXT":
    default:
      return TextQuestionFactory(
        rules: rules,
        type: QuestionType.TEXT,
      );
  }
}

class QuestionException implements Exception {
  String message;
  QuestionException(this.message);
}
