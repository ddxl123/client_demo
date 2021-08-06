import 'package:demo/data/mysql/vo/ResponseVOBase.dart';

class NullDataVO extends ResponseVOBase {
  @override
  ResponseVOBase from(Map<String, dynamic> dataJson) {
    return this;
  }
}
