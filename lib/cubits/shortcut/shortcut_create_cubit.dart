// file: shortcut_create_cubit.dart
// date: Feb/21/2023
// brief: Shortcut settings related cubit
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_create_model.dart';
import 'package:smarthq_flutter_module/resources/repositories/shortcut_service_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/shortcut_storage.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ShortcutCreateCubit extends Cubit<ShortcutCreateState> {
  static const String tag = "ShortcutCreateCubit:";

  late ShortcutServiceRepository _shortcutServiceRepository;
  late ShortcutService _shortcutService;
  late LocalDataManager _localDataManager;
  late ShortcutStorage _storage;

  ShortcutCreateCubit(
      this._shortcutServiceRepository,
      this._shortcutService,
      this._localDataManager)
      : super(ShortcutCreateInitiate()) {
    geaLog.debug("ShortcutCreateCubit is called");

    _storage = _localDataManager.getStorage(StorageType.shortcut) as ShortcutStorage;
  }

  void fetchApplianceType() async {
    geaLog.debug("$tag fetchApplianceType");

    emit(ShortcutCreateApplianceTypeLoaded(
        applianceType: _storage.selectedApplianceType)
    );
  }

  void fetchAvailableItems(String? applianceType, BuildContext context) async {
    geaLog.debug("$tag fetchAvailableItems");

    if (applianceType == ApplianceTypes.airConditioner) {
      fetchAvailableAcItems(null, context);
    } else if (applianceType == ApplianceTypes.oven) {
      fetchAvailableOvenItems();
    }
  }

  void fetchAvailableOvenItems() async {
    geaLog.debug("$tag fetchAvailableOvenItems");
    final applianceId = _storage.selectedApplianceId;
    final ovenRackType = _storage.selectedOvenRackType;
    dynamic availableModes = await _shortcutServiceRepository.fetchAvailableOvenModes(applianceId, ovenRackType);
    geaLog.debug("$tag fetchAvailableOvenModes - ${availableModes.ovenModes}");

    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableOvenTemps(applianceId, null);
    geaLog.debug("$tag fetchAvailableOvenItems - ${availableTemps.tempUnit}, ${availableTemps.ovenTemps}");

    emit(ShortcutCreateOvenDataLoaded(
        tempUnit: availableTemps.tempUnit,
        modeItems: availableModes.ovenModes,
        tempItems: availableTemps.ovenTemps));
  }

  void fetchAvailableOvenTemps(String? mode, List<String>? modeItems) async {
    geaLog.debug("$tag fetchAvailableMode $mode");
    final applianceId = _storage.selectedApplianceId;

    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableOvenTemps(applianceId, mode);

    emit(ShortcutCreateOvenDataLoaded(
        tempUnit: availableTemps.tempUnit,
        modeItems: modeItems,
        tempItems: availableTemps.ovenTemps));
  }

  void fetchAvailableAcItems(String? mode, BuildContext context) async {
    geaLog.debug("$tag fetchAvailableAcItems");
    final applianceId = _storage.selectedApplianceId;
    dynamic availableModes = await _shortcutServiceRepository.fetchAvailableAcModes(applianceId);

    String firstMode = (availableModes?.acModes?.length > 0)? availableModes?.acModes[0] : null;
    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableAcTemps(applianceId, firstMode, context);
    dynamic availableFans = await _shortcutServiceRepository.fetchAvailableAcFans(applianceId, firstMode, context);

    emit(ShortcutCreateAcDataLoaded(
        selectedMode: firstMode,
        tempUnit: availableTemps.tempUnit,
        modeItems: availableModes.acModes,
        tempItems: availableTemps.acTemps,
        fanItems: availableFans.acFans
    ));
  }

  void fetchAvailableAcTempsFans(String? mode, List<String>? modeItems, BuildContext context) async {
    geaLog.debug("$tag fetchAvailableAcFans $mode");
    final applianceId = _storage.selectedApplianceId;
    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableAcTemps(applianceId, mode, context);
    dynamic availableFans = await _shortcutServiceRepository.fetchAvailableAcFans(applianceId, mode, context);

    emit(ShortcutCreateAcDataLoaded(
        selectedMode: mode,
        tempUnit: availableTemps.tempUnit,
        modeItems: modeItems,
        tempItems: availableTemps.acTemps,
        fanItems: availableFans.acFans
    ));
  }

  void fetchApplianceDetails(String? applianceType) async {
    geaLog.debug("$tag fetchApplianceType");

    final applianceNickname = _storage.selectedApplianceNickname;
    final ovenRackType = _storage.selectedOvenRackType;

    emit(ShortcutCreateApplianceDetailLoaded(
        applianceNickname: applianceNickname,
        applianceType: applianceType,
        ovenRackType: ovenRackType));
  }

  Future<void> saveSelectedShortcut(String? nickname, String? mode, String? tempUnit, String? temp, String? fan) async {
    geaLog.debug("$tag saveSelectedShortcut $nickname, $mode, $tempUnit, $temp, $fan");
    final applianceType = _storage.selectedApplianceType;
    String? applianceNickname = _storage.selectedApplianceNickname;

    String? shortcutName = nickname;
    if (nickname == null || nickname.length == 0) {
      if (mode == null || mode.length == 0) {
        shortcutName = await _shortcutService.createDefaultShortcutNickname();
      } else {
        shortcutName = mode;
      }
    }

    final model = ShortcutSetItemModel(
        jid: _storage.selectedApplianceId,
        nickname: applianceNickname,
        shortcutName: shortcutName,
        shortcutType: ShortcutType.shortcutTypeMode.name,
        applianceType: applianceType,
        ovenRackType: (applianceType == ApplianceTypes.oven)? _storage.selectedOvenRackType : "",
        mode: mode,
        tempUnit: tempUnit,
        temp: temp,
        fan: fan
    );

    _storage.setSelectedShortcut = model;
  }

  Future<void> saveTurnOffShortcut(String? nickname, String? mode) async {
    geaLog.debug("$tag saveTurnOffShortcut $nickname");
    final applianceType = _storage.selectedApplianceType;
    String? applianceNickname = _storage.selectedApplianceNickname;

    String shortcutName = nickname ?? "";
    if (nickname == null || nickname.length == 0) {
      if (mode == null || mode.length == 0) {
        shortcutName = await _shortcutService.createDefaultShortcutNickname();
      } else {
        shortcutName = mode;
      }
    }

    final model = ShortcutSetItemModel(
        jid: _storage.selectedApplianceId,
        nickname: applianceNickname,
        shortcutName: shortcutName,
        shortcutType: ShortcutType.shortcutTypeTurnOff.name,
        applianceType: applianceType,
        ovenRackType: (applianceType == ApplianceTypes.oven)? _storage.selectedOvenRackType : "",
        mode: mode
    );

    _storage.setSelectedShortcut = model;
    _shortcutServiceRepository.notifyNewShortcutCreated(model);
    emit(ShortcutCreateTurnOffSucceeded(
      model: model
    ));
  }
}