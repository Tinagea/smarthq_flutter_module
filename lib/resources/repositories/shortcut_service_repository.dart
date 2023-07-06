// file: shortcut_service_repository.dart
// date: Nov/23/2022
// brief: A class for Shortcut service repository.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_result/shortcut_service_result_body.dart';

abstract class ShortcutServiceRepository {
  /// Appliance data for Shortcut
  Future<ShortcutServiceBodyOvenType?> fetchOvenType(String? jid);
  Future<ShortcutServiceBodyOvenModes?> fetchAvailableOvenModes(String? jid, String? type);
  Future<ShortcutServiceBodyOvenTemps?> fetchAvailableOvenTemps(String? jid, String? mode);
  Future<ShortcutServiceBodyAcModes?> fetchAvailableAcModes(String? jid);
  Future<ShortcutServiceBodyAcTemps?> fetchAvailableAcTemps(String? jid, String? mode, BuildContext context);
  Future<ShortcutServiceBodyAcFans?> fetchAvailableAcFans(String? jid, String? mode, BuildContext context);
  Future<String?> fetchAllShortcuts();
  Future<void> removeAllShortcuts();
  Future<void> notifyNewShortcutCreated(ShortcutSetItemModel? model);
  Future<void> notifyShortcutRemoved(ShortcutSetItemModel? model);
  Future<void> notifyShortcutGuidanceDone();
}

class ShortcutServiceRepositoryImpl implements ShortcutServiceRepository {
  static const String tag = "ShortcutServiceRepositoryImpl";

  late ChannelManager _channelManager;
  late SharedDataManager _sharedDataManager;

  ShortcutServiceRepositoryImpl({
    required ChannelManager channelManager,
    required SharedDataManager sharedDataManager,
  }) {
    _channelManager = channelManager;
    _sharedDataManager = sharedDataManager;
  }

  Future<ShortcutServiceBodyOvenType?> fetchOvenType(String? jid) async {
    if (jid == null) {
      return null;
    }

    dynamic ovenTypeResponse = await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_OVEN_TYPE,
        {'jid': jid});

    ShortcutServiceBodyOvenType? ovenTypeBody;
    if (ovenTypeResponse['ovenType']['body'] != null) {
      Map<String, dynamic> param = {...ovenTypeResponse['ovenType']['body']};
      ovenTypeBody = ShortcutServiceBodyOvenType.fromJson(param);
    }
    return ovenTypeBody;
  }

  Future<ShortcutServiceBodyOvenModes?> fetchAvailableOvenModes(String? jid,
      String? type) async {
    if (jid == null || type == null) {
      return null;
    }

    dynamic ovenModesResponse = await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_OVEN_MODES,
        {'jid': jid, 'type': type});

    ShortcutServiceBodyOvenModes? ovenModesBody;
    if (ovenModesResponse['ovenModes']['body'] != null) {
      Map<String, dynamic> param = {...ovenModesResponse['ovenModes']['body']};
      ovenModesBody = ShortcutServiceBodyOvenModes.fromJson(param);
    }

    return ovenModesBody;
  }

  Future<ShortcutServiceBodyOvenTemps?> fetchAvailableOvenTemps(String? jid,
      String? mode) async {
    if (jid == null) {
      return null;
    }

    dynamic ovenTempsResponse = await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_OVEN_TEMPS,
        {'jid': jid, 'mode': mode ?? ''});

    ShortcutServiceBodyOvenTemps? ovenTempsBody;
    if (ovenTempsResponse['ovenTemps']['body'] != null) {
      Map<String, dynamic> param = {...ovenTempsResponse['ovenTemps']['body']};
      ovenTempsBody = ShortcutServiceBodyOvenTemps.fromJson(param);
    }

    return ovenTempsBody;
  }


  Future<ShortcutServiceBodyAcModes?> fetchAvailableAcModes(String? jid) async {
    if (jid == null) {
      return null;
    }

    dynamic acModesResponse = await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_AC_MODES,
        {'jid': jid});

    ShortcutServiceBodyAcModes? acModesBody;
    if (acModesResponse['acModes']['body'] != null) {
      Map<String, dynamic> param = {...acModesResponse['acModes']['body']};
      acModesBody = ShortcutServiceBodyAcModes.fromJson(param);
    }

    return acModesBody;
  }

  Future<ShortcutServiceBodyAcTemps?> fetchAvailableAcTemps(String? jid, String? mode, BuildContext context) async {
    if (jid == null) {
      return ShortcutServiceBodyAcTemps(
          tempUnit: null,
          acTemps: null
      );
    }

    if (mode == LocaleUtil.getString(context, LocaleUtil.SHORTCUT_WAC_TURBO_COOL_MODE) ||
        mode == LocaleUtil.getString(context, LocaleUtil.SHORTCUT_WAC_FAN_ONLY_MODE)) {
      return ShortcutServiceBodyAcTemps(
          tempUnit: null,
          acTemps: null
      );
    }

    dynamic acTempsResponse = await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_AC_TEMPS,
        {'jid': jid});

    ShortcutServiceBodyAcTemps? acTempsBody;
    if (acTempsResponse['acTemps']['body'] != null) {
      Map<String, dynamic> param = {...acTempsResponse['acTemps']['body']};
      acTempsBody = ShortcutServiceBodyAcTemps.fromJson(param);
    }

    return acTempsBody;
  }

  Future<ShortcutServiceBodyAcFans?> fetchAvailableAcFans(String? jid,
      String? mode, BuildContext context) async {
    if (jid == null) {
      return ShortcutServiceBodyAcFans(
        acFans: null
      );
    }

    if (mode == LocaleUtil.getString(context, LocaleUtil.SHORTCUT_WAC_DRY_MODE) ||
        mode == LocaleUtil.getString(context, LocaleUtil.SHORTCUT_WAC_TURBO_COOL_MODE)) {
      return ShortcutServiceBodyAcFans(
          acFans: null
      );
    }

    dynamic acFansResponse = await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_AC_FANS,
        {'jid': jid, 'mode': mode ?? ''});

    ShortcutServiceBodyAcFans? acFansBody;
    if (acFansResponse['acFans']['body'] != null) {
      Map<String, dynamic> param = {...acFansResponse['acFans']['body']};
      acFansBody = ShortcutServiceBodyAcFans.fromJson(param);
    }

    return acFansBody;
  }

  Future<String?> fetchAllShortcuts() async {
    String? list = await _sharedDataManager.getStringValue(
        SharedDataKey.shortcutItems);
    return list;
  }

  Future<void> removeAllShortcuts() async {
    await _sharedDataManager.setStringValue(SharedDataKey.shortcutItems, null);
  }

  Future<void> notifyNewShortcutCreated(ShortcutSetItemModel? model) async {
    dynamic body = model?.toJson();
    await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_NOTIFYING_SHORTCUT_CREATED,
        {'body': body});
  }

  Future<void> notifyShortcutRemoved(ShortcutSetItemModel? model) async {
    dynamic body = model?.toJson();
    await _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_NOTIFYING_SHORTCUT_REMOVED,
        {'body': body});
  }
  Future<void> notifyShortcutGuidanceDone() async {
    _channelManager.actionDirectRequest(
        ChannelType.shortcutService,
        ShortcutServiceChannelProfile.F2N_DIRECT_NOTIFYING_SHORTCUT_GUIDANCE_DONE, null);
  }
}