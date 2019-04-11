import 'package:panelsmart/models/answers/decorator.dart';
import 'package:panelsmart/models/answers/singleSelectionAnswer.dart';
import 'package:panelsmart/models/answers/textAnswer.dart';
import 'package:panelsmart/models/questions/main.dart';

class Answer {
  dynamic result;
  Answer();

  factory Answer.withRules(Map<String, dynamic> rules, QuestionType type,
      {List<String> selections}) {
    Answer _answer;
    switch (type) {
      case QuestionType.SINGLE_SELECTIONS:
        _answer = SingleSelectionAnswer(selections: selections);
        break;
      case QuestionType.TEXT:
      default:
        _answer = TextAnswer();
    }
    return _answerRuleFactory(rules, _answer);
  }

  bool validate() => true;
}

Answer _answerRuleFactory(Map<String, dynamic> rules, Answer answer) {
  if (rules == null) return answer;
  rules.keys.forEach((String ruleType) {
    var ruleValue = rules[ruleType];
    switch (ruleType) {
      case 'maxLength':
        answer = MaxLengthRuleDecorator(answer,
            maxLength: ruleValue is! int ? int.parse(ruleValue) : ruleValue);
        break;
      case 'minLength':
        answer = MinLengthRuleDecorator(answer,
            minLength: ruleValue is! int ? int.parse(ruleValue) : ruleValue);
        break;
      case 'required':
        answer = RequiredRuleDecorator(answer);
        break;
      default:
        break;
    }
  });
  return answer;
}
