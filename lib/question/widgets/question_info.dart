import 'package:flutter/material.dart';

class QuestionInfo extends StatelessWidget {
  final String description;
  QuestionInfo({this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Text(description)],
    );
  }
}
