import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/entry_point.dart';
import 'package:smarthq_flutter_module/resources/channels/api_service_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/appliance_service_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/dialog_channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/main_channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/local_appliance_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_channel_profile.dart';

enum ChannelType {
  /// These are used in MainChannelManager
  native(NativeChannelProfile.CHANNEL_NAME),
  apiService(APIServiceChannelProfile.CHANNEL_NAME),
  applianceService(ApplianceServiceChannelProfile.CHANNEL_NAME),
  commissioning(CommissioningChannelProfile.CHANNEL_NAME),
  bleCommissioning(BleCommissioningChannelProfile.CHANNEL_NAME),
  localApplianceCommissioning(LocalApplianceCommissioningChannelProfile.CHANNEL_NAME),
  shortcutService(ShortcutServiceChannelProfile.CHANNEL_NAME),

  /// These are used in DialogChannelManager
  dialog(DialogChannelProfile.CHANNEL_NAME);


  const ChannelType(this.name);
  final String name;
}

abstract class ChannelHandler {
  StreamController streamController;
  ChannelHandler(this.streamController);
  Future<dynamic> handleMethod(MethodCall call) async {
    throw UnimplementedError();
  }
}

abstract class ChannelManager {
  factory ChannelManager(EntryPointType entryPointType) {
    switch(entryPointType) {
      case EntryPointType.main:
        return MainChannelManager();
      case EntryPointType.dialog:
        return DialogChannelManager();
    }
  }

  Stream getStream();
  void close();

  Future<bool> isRunningOnNative();
  Future<void> readyToService();

  void actionRequest(ChannelType channelType, String methodName, dynamic parameter);
  Future<dynamic> actionDirectRequest(ChannelType channelType, String methodName, dynamic parameter);
}


