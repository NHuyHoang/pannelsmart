import 'package:panelsmart/models/answers/main.dart';

class AnswerRuleDecorator implements Answer {
  final Answer answer;

  AnswerRuleDecorator({this.answer});

  @override
  bool validate() => true;

  @override
  dynamic get result => answer.result;

  @override
  set result(_answerValue) {
    answer.result = _answerValue;
  }
}

class MaxLengthRuleDecorator extends AnswerRuleDecorator {
  final int maxLength;

  MaxLengthRuleDecorator(
    Answer answer, {
    this.maxLength,
  }) : super(answer: answer);

  @override
  bool validate() {
    bool isValid = answer.validate();
    return isValid != false && result.length < maxLength;
  }
}

class MinLengthRuleDecorator extends AnswerRuleDecorator {
  final int minLength;
  MinLengthRuleDecorator(Answer answer, {this.minLength})
      : super(answer: answer);

  @override
  bool validate() {
    bool isValid = answer.validate();
    return isValid != false && (result.length > minLength);
  }
}

class RequiredRuleDecorator extends AnswerRuleDecorator {
  RequiredRuleDecorator(Answer answer) : super(answer: answer);

  @override
  bool validate() {
    bool isValid = answer.validate();
    return isValid && (result != null);
  }
}
