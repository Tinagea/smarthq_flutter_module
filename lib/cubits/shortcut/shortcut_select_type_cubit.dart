// file: shortcut_select_type_cubit.dart
// date: Feb/17/2023
// brief: Shortcut select appliance related cubit
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_select_type_model.dart';
import 'package:smarthq_flutter_module/resources/storage/shortcut_storage.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ShortcutSelectTypeCubit extends Cubit<ShortcutSelectTypeState> {
  static const String tag = "ShortcutSelectTypeCubit:";

  late LocalDataManager _localDataManager;
  late ShortcutStorage _storage;

  ShortcutSelectTypeCubit(this._localDataManager)
      : super(ShortcutSelectTypeInitiate()) {
    geaLog.debug("ShortcutSelectTypeCubit is called");

    _storage = _localDataManager.getStorage(StorageType.shortcut) as ShortcutStorage;
  }

  Future<String?> getSavedSelectedOvenType() async {
    geaLog.debug("$tag getSavedSelectedOvenType");
    return _storage.selectedOvenType;
  }

  void saveSelectedOvenType(String? type) {
    geaLog.debug("$tag saveSelectedOvenType - $type");
    _storage.setSelectedOvenType = type;
  }

  void saveSelectedOvenRackType(String? type) {
    geaLog.debug("$tag saveSelectedOvenRackType - $type");
    _storage.setSelectedOvenRackType = type;
  }

  Future<String?> getSavedSelectedApplianceType() async {
    geaLog.debug("$tag getSavedSelectedApplianceType");
    return _storage.selectedApplianceType;
  }
}
