
import 'package:smarthq_flutter_module/entry_point.dart';
import 'package:smarthq_flutter_module/managers/test_mananger/dialog_test_manager.dart';
import 'package:smarthq_flutter_module/managers/test_mananger/main_test_manager.dart';

abstract class TestManager {
  factory TestManager({
    required EntryPointType entryPointType}) {
    switch(entryPointType) {
      case EntryPointType.main:
        return MainTestManager();
      case EntryPointType.dialog:
        return DialogTestManager();
    }
  }

  Future<void> initialize();
  void testAction({required int actionNumber});
}