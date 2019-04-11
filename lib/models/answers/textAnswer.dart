import 'package:panelsmart/models/answers/main.dart';

class TextAnswer extends Answer {
  TextAnswer();

  @override
  dynamic get result {
    try {
      if (!validate()) return null;
      return super.result;
    } catch (e) {
      print(e);
    }
  }

  @override
  set result(dynamic _result) {
    super.result = _result;
  }

  @override
  bool validate() => super.result is String;
}
