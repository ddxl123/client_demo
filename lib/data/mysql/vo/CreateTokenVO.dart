import 'package:demo/data/model/MToken.dart';
import 'package:demo/data/mysql/vo/ResponseVOBase.dart';

class CreateTokenVO extends ResponseVOBase {
  late String emailToken;

  @override
  CreateTokenVO from(Map<String, dynamic> dataJson) {
    final MToken forKey = MToken();
    emailToken = dataJson[forKey.token] as String;
    return this;
  }
}
