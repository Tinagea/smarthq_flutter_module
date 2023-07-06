// file: shortcut_entry_cubit.dart
// date: Feb/17/2023
// brief: Shortcut create related cubit
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_entry_model.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/appliance_list_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/api_service_repository.dart';
import 'package:smarthq_flutter_module/resources/repositories/shortcut_service_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/shortcut_storage.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ShortcutEntryCubit extends Cubit<ShortcutEntryState> {
  static const String tag = "ShortcutEntryCubit:";

  late ShortcutServiceRepository _shortcutServiceRepository;
  late ApiServiceRepository _apiServiceRepository;
  late LocalDataManager _localDataManager;
  late ShortcutStorage _storage;

  ShortcutEntryCubit(
      this._shortcutServiceRepository,
      this._apiServiceRepository,
      this._localDataManager)
      : super(ShortcutEntryInitiate()) {
    geaLog.debug("ShortcutEntryCubit is called");

    _storage = _localDataManager.getStorage(StorageType.shortcut) as ShortcutStorage;
    _initShortcutStorage();
  }

  void _initShortcutStorage() {
    _storage.setSelectedApplianceId = "";
    _storage.setSelectedShortcut = null;
  }

  void getAvailableApplianceList() async {
    geaLog.debug("$tag: getAvailableApplianceList");

    emit(ShortcutEntryLoading());

    List<ApplianceListItem>? applianceList = await _apiServiceRepository.getApplianceList();

    emit(ShortcutEntryAppliancesLoaded(
        applianceList: applianceList)
    );
  }

  void fetchOvenType(String? jid) async {
    dynamic ovenTypeBody = await _shortcutServiceRepository.fetchOvenType(jid);
    geaLog.debug("$tag fetchOvenType - ${ovenTypeBody.ovenType}");

    emit(ShortcutEntryOvenTypeLoaded(
        jid: jid,
        ovenType:ovenTypeBody.ovenType)
    );
  }

  void fetchOvenRackTypeScreen(String? ovenType) {
    if (ovenType == OvenType.singleOven.name) {
      emit(ShortcutEntryOvenSingleOvenSelected(
        ovenRackType: OvenRackType.upperOven.name// single oven treats oven rack as upper
      ));
    } else {
      emit(ShortcutEntryOvenDoubleOvenSelected());
    }
  }

  void saveSelectedAppliance(ApplianceListItem? appliance) {
    geaLog.debug("$tag saveSelectedAppliance - ${appliance?.jid}");
    _storage.setSelectedApplianceId = appliance?.jid;
    _storage.setSelectedApplianceType = appliance?.type;
    _storage.setSelectedApplianceNickname = appliance?.nickname;
  }

  void saveSelectedOvenType(String? type) {
    geaLog.debug("$tag saveSelectedOvenType - $type");
    _storage.setSelectedOvenType = type;
  }

  void saveSelectedOvenRackType(String? type) {
    geaLog.debug("$tag saveSelectedOvenRackType - $type");
    _storage.setSelectedOvenRackType = type;
  }
}