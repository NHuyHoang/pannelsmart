import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panelsmart/models/questions/main.dart';
import 'package:panelsmart/question/question.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
 
  @override
  void initState() {
    super.initState();
    DatabaseReference ref =
        FirebaseDatabase.instance.reference().child('quests');

    
    // print(q.answer.validate());
    // print(q.answer.result);
  }

  Future<void> _fetchQuestions(List<String> ids) async {
    List<Future> futures = [];
    this.setState(() => loading = true);
    ids.forEach((String id) {
      DatabaseReference ref =
          FirebaseDatabase.instance.reference().child('questions/$id');
      futures.add(ref.once().then((DataSnapshot data) => data.value));
    });
    var results = await Future.wait(futures);
    this.setState(() => loading = false);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return QuestionScreen(
        questionList: results,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("PanelSmart")),
        body: Stack(
          children: <Widget>[
            loading
                ? SizedBox(
                    height: 4.0,
                    child: LinearProgressIndicator(),
                  )
                : Container(),
            FutureBuilder(
              future:
                  FirebaseDatabase.instance.reference().child('quests').once(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic> data = snapshot.data.value;
                  var listQuest = data.values.toList();
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: listQuest.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = listQuest[index];
                      return QuestRow(
                        name: item['name'],
                        description: item['description'],
                        onPress: () {
                          if (loading) return;
                          _fetchQuestions(
                              item['questions']?.cast<String>() ?? []);
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
          ],
        ));
  }
}

class QuestRow extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onPress;
  QuestRow({this.name, this.description, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      title: Text(name),
      subtitle: Text(
        description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onPress,
      trailing: Icon(
        FontAwesomeIcons.chevronRight,
        size: 12,
      ),
    );
    ;
  }
}
