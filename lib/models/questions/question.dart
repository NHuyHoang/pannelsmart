import 'package:meta/meta.dart';

abstract class Question {
  @protected
  final String description;

  @protected
  final String type;
  Question({this.description, @required this.type});

  bool validate();
}
