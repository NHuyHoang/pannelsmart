import 'package:flutter/material.dart';
import 'package:panelsmart/models/questions/main.dart';

class TextQuestionAnswerView extends StatefulWidget {
  final Question question;
  TextQuestionAnswerView(this.question);
  @override
  _TextQuestionAnswerViewState createState() => _TextQuestionAnswerViewState();
}

class _TextQuestionAnswerViewState extends State<TextQuestionAnswerView> {
  TextEditingController controller;
  bool _valid = true;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      String text = controller.text;
      widget.question.answer.result = text;
      this.setState(() {
        _valid = widget.question.answer.validate();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        print(value);
      },
      decoration: InputDecoration(
        labelText: 'Enter the Value',
        errorText: _valid ? null : 'Value Can\'t Be Empty',
      ),
      controller: controller,
    );
  }
}
