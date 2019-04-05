import 'package:panelsmart/models/questions/question.dart';

abstract class Rule {
  Rule();

  bool validate();
}

class QuestionRuleDecorator implements Question {
  final Question question;

  QuestionRuleDecorator({this.question});

  @override
  String get description => question.description;

  @override
  String get type => question.type;

  @override
  bool validate() {
    return question.validate();
  }
}

class LengthRuleDecorator extends QuestionRuleDecorator {

  @override
  bool validate() {
    bool isValid = super.validate();
    return isValid && true;
  }
}
