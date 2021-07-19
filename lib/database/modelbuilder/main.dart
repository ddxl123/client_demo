import 'dart:io';

import 'package:demo/database/modelbuilder/model/AppVersionInfoModel.dart';
import 'package:demo/database/modelbuilder/model/UserInfoModel.dart';
import 'package:demo/database/modelbuilder/model/UserModel.dart';

import 'builder/Writer.dart';
import 'builder/creator/ModelCreator.dart';

void main(List<String> args) {
  Writer(
    folderPath: Directory.current.path + '/lib/database/model',
    models: <ModelCreator>[
      UserModel(),
      UserInfoModel(),
      AppVersionInfoModel(),
    ],
  );
}
