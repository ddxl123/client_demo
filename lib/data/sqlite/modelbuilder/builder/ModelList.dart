        import './creator/ModelCreator.dart';
    
              import '../model/CAppVersionInfo.dart';
            import '../model/CUpload.dart';
            import '../model/CUser.dart';
            import '../model/f/CFComplete.dart';
            import '../model/f/CFFragment.dart';
            import '../model/f/CFMemory.dart';
            import '../model/f/CFRule.dart';
            import '../model/pn/CPnComplete.dart';
            import '../model/pn/CPnFragment.dart';
            import '../model/pn/CPnMemory.dart';
            import '../model/pn/CPnRule.dart';
      
    class ModelList{
      List<ModelCreator> modelCreators = <ModelCreator>[
            CAppVersionInfo(),
            CUpload(),
            CUser(),
            CFComplete(),
            CFFragment(),
            CFMemory(),
            CFRule(),
            CPnComplete(),
            CPnFragment(),
            CPnMemory(),
            CPnRule(),
      
      ];
    }

    