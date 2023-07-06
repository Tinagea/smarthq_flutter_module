// file: shortcut_get_started_cubit.dart
// date: May/12/2023
// brief: Shortcut get started related cubit
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_get_started_model.dart';
import 'package:smarthq_flutter_module/resources/repositories/shortcut_service_repository.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ShortcutGetStartedCubit extends Cubit<ShortcutGetStartedInitiate> {
  static const String tag = "ShortcutGetStartedCubit:";

  late ShortcutServiceRepository _shortcutServiceRepository;

  ShortcutGetStartedCubit(
      this._shortcutServiceRepository)
      : super(ShortcutGetStartedInitiate()) {
    geaLog.debug("ShortcutGetStartedCubit is called");
  }

  void finishGuidance() {
    geaLog.debug("$tag finishGuidance");
    _shortcutServiceRepository.notifyShortcutGuidanceDone();
  }
}