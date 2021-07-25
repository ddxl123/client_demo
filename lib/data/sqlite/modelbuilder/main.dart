import 'dart:io';

import 'builder/Writer.dart';
import 'builder/creator/ModelCreator.dart';
import 'model/AppVersionInfoModel.dart';

void main(List<String> args) {
  Writer(
    folderPath: Directory.current.path + '/lib/database/model',
    models: <ModelCreator>[
      AppVersionInfoModel(),
    ],
  );
}
