        import './creator/ModelCreator.dart';
    
              import '../model/local/CAppVersionInfo.dart';
            import '../model/local/CToken.dart';
            import '../model/local/CUpload.dart';
            import '../model/nonlocal/CUser.dart';
            import '../model/nonlocal/f/CFComplete.dart';
            import '../model/nonlocal/f/CFFragment.dart';
            import '../model/nonlocal/f/CFMemory.dart';
            import '../model/nonlocal/f/CFRule.dart';
            import '../model/nonlocal/pn/CPnComplete.dart';
            import '../model/nonlocal/pn/CPnFragment.dart';
            import '../model/nonlocal/pn/CPnMemory.dart';
            import '../model/nonlocal/pn/CPnRule.dart';
      
    class ModelList{
      List<ModelCreator> modelCreators = <ModelCreator>[
            CAppVersionInfo(),
            CToken(),
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

    