import 'package:panelsmart/models/questions/question.dart';

abstract class Rule {
  Rule();

  bool validate();
}

class AnswerRuleDecorator implements Answer {
  final Answer answer;

  AnswerRuleDecorator({this.answer});

  @override
  bool validate() {
    return answer.validate();
  }

  @override
  void set answerText(String _answerText) => answer.answerText = _answerText;

  @override
  String get answerText => answer.answerText;
}

class MaxLengthRuleDecorator extends AnswerRuleDecorator {
  final int maxLength;

  MaxLengthRuleDecorator(
    Answer answer, {
    this.maxLength,
  }) : super(answer: answer);

  @override
  bool validate() {
    bool isValid = super.validate();
    if (isValid) return false;
    if (answerText.length > maxLength) return false;
    return true;
  }
}

class MinLengthRuleDecorator extends AnswerRuleDecorator {
  final int minLength;
  MinLengthRuleDecorator(Answer answer, {this.minLength})
      : super(answer: answer);

  @override
  bool validate() {
    bool isValid = super.validate();
    if (isValid) return false;
    if (answerText.length < minLength) return false;
    return true;
  }
}
