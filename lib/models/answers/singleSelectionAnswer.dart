import 'package:meta/meta.dart';
import 'package:panelsmart/models/answers/main.dart';

class SingleSelectionAnswer extends Answer {
  List<String> selections;
  SingleSelectionAnswer({@required this.selections});

  // @override
  // bool validate() => super.validate();

  @override
  set result(dynamic _result) {
    int res = int.parse(_result);
    result = selections[res];
  }
}
