import 'package:flutter/material.dart';
import 'package:panelsmart/models/questions/main.dart';
import 'package:panelsmart/question/widgets/question_info.dart';
import 'package:panelsmart/question/widgets/text_question.dart';

class QuestionView {
  final Question question;
  Widget infoView;
  Widget answerView;

  QuestionView({
    this.question,
  }) {
    infoView = QuestionInfo(
      description: question.description,
    );
  }
}

class TextQuestionView extends QuestionView {
  final Question question;
  TextQuestionView({this.question}) : super(question: question) {
    answerView = TextQuestionAnswerView(question);
  }
}
