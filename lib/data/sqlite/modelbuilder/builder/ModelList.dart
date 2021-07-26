        import './creator/ModelCreator.dart';
    
              import '../model/f/MFComplete.dart';
            import '../model/f/MFFragment.dart';
            import '../model/f/MFMemory.dart';
            import '../model/f/MFRule.dart';
            import '../model/MAppVersionInfo.dart';
            import '../model/MUser.dart';
            import '../model/pn/MPnComplete.dart';
            import '../model/pn/MPnFragment.dart';
            import '../model/pn/MPnMemory.dart';
            import '../model/pn/MPnRule.dart';
      
    class ModelList{
      List<ModelCreator> modelCreators = <ModelCreator>[
            MFComplete(),
            MFFragment(),
            MFMemory(),
            MFRule(),
            MAppVersionInfo(),
            MUser(),
            MPnComplete(),
            MPnFragment(),
            MPnMemory(),
            MPnRule(),
      
      ];
    }

    