import 'dart:async';

import 'package:flutter/services.dart';

import 'package:smarthq_flutter_module/resources/channels/api_service_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/api_service_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/appliance_service_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/appliance_service_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_method_mock_up.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/local_appliance_commissioning_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/local_appliance_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_channel_profile.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class MainChannelManager implements ChannelManager {
  static const String tag = "MainChannelManager:";

  static final MainChannelManager _singleton = new MainChannelManager._internal();

  late StreamController _broadCast;

  final methodChannels = [
    const MethodChannel(NativeChannelProfile.CHANNEL_NAME),
    const MethodChannel(APIServiceChannelProfile.CHANNEL_NAME),
    const MethodChannel(ApplianceServiceChannelProfile.CHANNEL_NAME),
    const MethodChannel(CommissioningChannelProfile.CHANNEL_NAME),
    const MethodChannel(BleCommissioningChannelProfile.CHANNEL_NAME),
    const MethodChannel(LocalApplianceCommissioningChannelProfile.CHANNEL_NAME),
    const MethodChannel(ShortcutServiceChannelProfile.CHANNEL_NAME),
  ];

  factory MainChannelManager() {
    return _singleton;
  }

  MainChannelManager._internal() {
    geaLog.debug("$tag._internal");

    _broadCast = StreamController.broadcast();

    _getChannel(ChannelType.native).setMethodCallHandler(NativeChannelHandler(_broadCast).handleMethod);
    _getChannel(ChannelType.apiService).setMethodCallHandler(APIServiceChannelHandler(_broadCast).handleMethod);
    _getChannel(ChannelType.applianceService).setMethodCallHandler(ApplianceServiceChannelHandler(_broadCast).handleMethod);
    _getChannel(ChannelType.commissioning).setMethodCallHandler(CommissioningChannelHandler(_broadCast).handleMethod);
    _getChannel(ChannelType.bleCommissioning).setMethodCallHandler(BleCommissioningChannelHandler(_broadCast).handleMethod);
    _getChannel(ChannelType.localApplianceCommissioning).setMethodCallHandler(LocalApplianceCommissioningChannelHandler(_broadCast).handleMethod);
    _getChannel(ChannelType.shortcutService).setMethodCallHandler(ShortcutServiceChannelHandler(_broadCast).handleMethod);
  }

  MethodChannel _getChannel(ChannelType channelType) {
    final index = methodChannels.indexWhere((channel) => channel.name == channelType.name);
    assert(index != -1, '$channelType is not included in the channel list');
    return methodChannels[index];
  }

  @override
  Stream getStream() {
    return _broadCast.stream;
  }

  Future<void> _actionRequest(ChannelType channelType, String methodName, dynamic parameter ) async {
    try {
      geaLog.debug("$tag:Action Method call[$channelType][$methodName]($parameter)");
      await _getChannel(channelType).invokeMethod(methodName, parameter);
    }
    on MissingPluginException {
      geaLog.debug("$tag:There is no invoke method");
      return await ChannelMethodMockUp().getMockUp(channelType, methodName, parameter);
    }
    on PlatformException {
      geaLog.debug("$tag:PlatformException!!!");
    }
  }

  @override
  void actionRequest(ChannelType channelType, String methodName, dynamic parameter) {
    _actionRequest(channelType, methodName, parameter);
  }

  Future<dynamic> _actionDirectRequest(ChannelType channelType, String methodName, dynamic parameter ) async {
    try {
      geaLog.debug("$tag:Action Method call[$channelType][$methodName]($parameter)");
      return await _getChannel(channelType).invokeMethod(methodName, parameter);
    }
    on MissingPluginException {
      geaLog.debug("$tag:There is no invoke method");
      return await ChannelMethodMockUp().getMockUp(channelType, methodName, parameter);
    }
    on PlatformException {
      geaLog.debug("$tag:PlatformException!!!");
    }
  }

  @override
  Future<dynamic> actionDirectRequest(ChannelType channelType, String methodName, dynamic parameter) async {
    return await _actionDirectRequest(channelType, methodName, parameter);
  }

  @override
  void close() {
    _broadCast.close();
  }

  @override
  Future<bool> isRunningOnNative() async {
    geaLog.debug("$tag:isRunningOnNative");
    try {
      await _getChannel(ChannelType.native).invokeMethod(NativeChannelProfile.F2N_DIRECT_IS_RUNNING_ON_NATIVE, null);
      return true;
    }
    on MissingPluginException {
      geaLog.debug("$tag:There is no \"IS_RUNNING_ON_NATIVE\" method");
      return false;
    }
    on PlatformException {
      geaLog.debug("$tag:PlatformException!!!");
      return false;
    }
  }

  @override
  Future<void> readyToService() async {
    geaLog.debug("$tag:readyToService");
    try {
      await _getChannel(ChannelType.native).invokeMethod(NativeChannelProfile.F2N_DIRECT_READY_TO_SERVICE, null);
    }
    on MissingPluginException {
      geaLog.debug("$tag:There is no \"READY_TO_SERVICE\" method");
    }
    on PlatformException {
      geaLog.debug("$tag:PlatformException!!!");
    }
  }
}
