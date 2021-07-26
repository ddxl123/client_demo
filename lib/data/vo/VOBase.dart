import 'package:demo/data/model/ModelBase.dart';

abstract class VOBase {
  VOBase from(ModelBase model);

  List<VOBase> froms(List<ModelBase> models);
}
