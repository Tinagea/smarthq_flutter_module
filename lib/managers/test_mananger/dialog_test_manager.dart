
import 'package:smarthq_flutter_module/managers/managers.dart';

class DialogTestManager implements TestManager{
  static const tag = "DialogTestManager:";

  DialogTestManager._();
  static final DialogTestManager _instance = DialogTestManager._();
  factory DialogTestManager() {
    return _instance;
  }

  @override
  Future<void> initialize() async {
    /// Get Resources for Dialog Test
  }

  @override
  void testAction({required int actionNumber}) async {
    switch (actionNumber) {
      case 0:

        break;
      case 1:

        break;
      case 2:

        break;
      default:

        break;
    }
  }
}