import 'package:demo/data/model/MPnComplete.dart';
import 'package:demo/data/model/MPnFragment.dart';
import 'package:demo/data/model/MPnMemory.dart';
import 'package:demo/data/model/MPnRule.dart';
import 'package:demo/muc/view/homepage/longpressnode/entrybase/LongPressNodeRouteEntryBase.dart';

class LongPressNodeForFragmentPoolRoute extends LongPressNodeRouteEntryBase<MPnFragment> {
  LongPressNodeForFragmentPoolRoute(MPnFragment poolNodeModel) : super(poolNodeModel);
}

class LongPressNodeForMemoryPoolRoute extends LongPressNodeRouteEntryBase<MPnMemory> {
  LongPressNodeForMemoryPoolRoute(MPnMemory poolNodeModel) : super(poolNodeModel);
}

class LongPressNodeForCompletePoolRoute extends LongPressNodeRouteEntryBase<MPnComplete> {
  LongPressNodeForCompletePoolRoute(MPnComplete poolNodeModel) : super(poolNodeModel);
}

class LongPressNodeForRulePoolRoute extends LongPressNodeRouteEntryBase<MPnRule> {
  LongPressNodeForRulePoolRoute(MPnRule poolNodeModel) : super(poolNodeModel);
}
