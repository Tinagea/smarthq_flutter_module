// file: shortcut_edit_cubit.dart
// date: Mar/03/2023
// brief: Shortcut editing related cubit
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_edit_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/resources/repositories/shortcut_service_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/shortcut_storage.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ShortcutEditCubit extends Cubit<ShortcutEditState> {
  static const String tag = "ShortcutEditCubit:";

  late ShortcutServiceRepository _shortcutServiceRepository;
  late ShortcutService _shortcutService;
  late LocalDataManager _localDataManager;
  late ShortcutStorage _storage;

  ShortcutEditCubit(
      this._shortcutServiceRepository,
      this._shortcutService,
      this._localDataManager)
      : super(ShortcutEditInitiate()) {
    geaLog.debug("ShortcutEditCubit is called");

    _storage = _localDataManager.getStorage(StorageType.shortcut) as ShortcutStorage;
  }

  Future<void> getSelectedShortcut(String? shortcutId) async {
    final shortcut = await _shortcutService.fetchStoredShortcut(shortcutId);
    if (shortcut?.item?.shortcutType == ShortcutType.shortcutTypeTurnOff.name) {
      emit(ShortcutEditSavedTurnOffShortcut(
          model: shortcut));
    } else {
      emit(ShortcutEditSavedShortcut(
          model: shortcut));
    }
  }

  void fetchAvailableItems(String? shortcutId, BuildContext context) async {
    geaLog.debug("$tag fetchAvailableItems");
    final shortcut = await _shortcutService.fetchStoredShortcut(shortcutId);

    if (shortcut?.item?.applianceType == ApplianceTypes.airConditioner) {
      fetchAvailableAcItems(shortcut, context);
    } else if (shortcut?.item?.applianceType == ApplianceTypes.oven) {
      fetchAvailableOvenItems(shortcut);
    }
  }

  void fetchAvailableOvenItems(ShortcutSetListModel? model) async {
    geaLog.debug("$tag fetchAvailableOvenItems");
    dynamic availableModes = await _shortcutServiceRepository.fetchAvailableOvenModes(model?.item?.jid, model?.item?.ovenRackType);
    geaLog.debug("$tag fetchAvailableOvenModes - ${availableModes.ovenModes}");

    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableOvenTemps(model?.item?.jid, null);
    geaLog.debug("$tag fetchAvailableOvenItems - ${availableTemps.tempUnit}, ${availableTemps.ovenTemps}");

    emit(ShortcutEditOvenDataLoaded(
        tempUnit: availableTemps.tempUnit,
        modeItems: availableModes.ovenModes,
        tempItems: availableTemps.ovenTemps));
  }

  void fetchAvailableOvenTemps(String? shortcutId, String? mode, List<String>? modeItems) async {
    geaLog.debug("$tag fetchAvailableMode $mode");
    final shortcut = await _shortcutService.fetchStoredShortcut(shortcutId);

    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableOvenTemps(shortcut?.item?.jid, mode);

    emit(ShortcutEditOvenDataLoaded(
        tempUnit: availableTemps.tempUnit,
        modeItems: modeItems,
        tempItems: availableTemps.ovenTemps));
  }

  void fetchAvailableAcItems(ShortcutSetListModel? model, BuildContext context) async {
    geaLog.debug("$tag fetchAvailableAcItems");
    dynamic availableModes = await _shortcutServiceRepository.fetchAvailableAcModes(model?.item?.jid);
    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableAcTemps(model?.item?.jid, model?.item?.mode, context);
    dynamic availableFans = await _shortcutServiceRepository.fetchAvailableAcFans(model?.item?.jid, model?.item?.mode, context);

    emit(ShortcutEditAcDataLoaded(
        selectedMode: model?.item?.mode,
        tempUnit: availableTemps.tempUnit,
        modeItems: availableModes.acModes,
        tempItems: availableTemps.acTemps,
        fanItems: availableFans.acFans
    ));
  }

  void fetchAvailableAcTempsFans(String? shortcutId, String? mode, List<String>? modeItems, BuildContext context) async {
    geaLog.debug("$tag fetchAvailableAcFans $mode");
    final shortcut = await _shortcutService.fetchStoredShortcut(shortcutId);
    dynamic availableTemps = await _shortcutServiceRepository.fetchAvailableAcTemps(shortcut?.item?.jid, mode, context);
    dynamic availableFans = await _shortcutServiceRepository.fetchAvailableAcFans(shortcut?.item?.jid, mode, context);

    emit(ShortcutEditAcDataLoaded(
        selectedMode: mode,
        tempUnit: availableTemps.tempUnit,
        modeItems: modeItems,
        tempItems: availableTemps.acTemps,
        fanItems: availableFans.acFans
    ));
  }

  void fetchApplianceDetails(String? shortcutId) async {
    geaLog.debug("$tag fetchApplianceDetails");

    final shortcut = await _shortcutService.fetchStoredShortcut(shortcutId);

    emit(ShortcutEditApplianceDetailLoaded(
        applianceNickname: shortcut?.item?.nickname,
        applianceType: shortcut?.item?.applianceType,
        ovenRackType: shortcut?.item?.ovenRackType));
  }

  Future<void> removeCurrentShortcut(String? id) async {
    geaLog.debug("$tag removeCurrentShortcut");
    await _shortcutService.removeStoredShortcut(id);

    ShortcutSetListModel? model = await _shortcutService.fetchStoredShortcut(id);
    _shortcutServiceRepository.notifyShortcutRemoved(model?.item);
    emit(ShortcutEditRemoveSucceeded());
  }

  Future<void> saveCurrentShortcut(
      String? id, String? jid, String? applianceNickname, String? applianceType, String? ovenRackType,
      String? nickname, String? shortcutType,
      String? mode, String? tempUnit, String? temp, String? fan) async {
    geaLog.debug("$tag saveCurrentShortcut $id, $nickname, $mode, $tempUnit, $temp, $fan");

    String? shortcutName = nickname;
    if (nickname == null || nickname.length == 0) {
      if (mode == null || mode.length == 0) {
        shortcutName = await _shortcutService.createDefaultShortcutNickname();
      } else {
        shortcutName = mode;
      }
    }

    final model = ShortcutSetItemModel(
        jid: jid,
        nickname: applianceNickname,
        shortcutName: shortcutName,
        shortcutType: shortcutType,
        applianceType: applianceType,
        ovenRackType: ovenRackType,
        mode: mode,
        tempUnit: tempUnit,
        temp: temp,
        fan: fan
    );

    _storage.setEditedShortcut = ShortcutSetListModel(shortcutId: id, item: model);
  }

  Future<void> saveTurnOffShortcut(String? id, String? jid, String? applianceNickname, String? applianceType, String? ovenRackType,
      String? nickname, String? shortcutType,
      String? mode) async {
    geaLog.debug("$tag saveTurnOffShortcut $id, $nickname");

    String? shortcutName = nickname;
    if (nickname == null || nickname.length == 0) {
      if (mode == null || mode.length == 0) {
        shortcutName = await _shortcutService.createDefaultShortcutNickname();
      } else {
        shortcutName = mode;
      }
    }

    final model = ShortcutSetItemModel(
        jid: jid,
        nickname: applianceNickname,
        shortcutName: shortcutName,
        shortcutType: shortcutType,
        applianceType: applianceType,
        ovenRackType: ovenRackType,
        mode: mode
    );

    await _shortcutService.updateShortcut(id, model);
    emit(ShortcutEditTurnOffSucceeded());
  }
}