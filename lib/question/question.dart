import 'package:flutter/material.dart';
import 'package:panelsmart/models/questions/main.dart';

class QuestionScreen extends StatefulWidget {
  final List<dynamic> questionList;

  QuestionScreen({this.questionList});

  @override
  _QuestionScreenState createState() => _QuestionScreenState(); 
}

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Question q;

  List<Widget> _renderList() {
    List<Widget> _questionViews = [];
    widget.questionList.forEach((question) => _questionViews.add(QuestionView(
          title: question['description'],
        )));
    return _questionViews.toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: widget.questionList.length);

    Map<String, dynamic> json = {
      "description": "info view 01",
      "rule": {
        "maxLength": 10,
        "minLength": 4,
      },
      "type": "TEXT",
      "id": "123kljfoiweur_efhwOkwe"
    };
    q = Question.jsonFactory(json);
    q.answer.result = 'hello';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: Column(
          children: <Widget>[
            q.questionView.infoView,
            q.questionView.answerView,
            RaisedButton(onPressed: () {
              print(q.answer.validate());
            }),
          ],
        ) /*TabBarView(
        controller: _tabController,
        children: _renderList(),
      ),*/
          );
  }
}

class QuestionView extends StatefulWidget {
  final String title;
  QuestionView({this.title});
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.title),
    );
  }
}
