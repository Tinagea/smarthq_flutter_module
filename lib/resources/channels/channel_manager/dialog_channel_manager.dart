import 'dart:async';

import 'package:flutter/services.dart';

import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_method_mock_up.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_channel_handler.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_channel_profile.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class DialogChannelManager implements ChannelManager {
  static const String tag = "DialogChannelManager:";

  static final DialogChannelManager _singleton = new DialogChannelManager._internal();

  late StreamController _broadCast;

  final methodChannels = [
    const MethodChannel(DialogChannelProfile.CHANNEL_NAME),
  ];

  factory DialogChannelManager() {
    return _singleton;
  }

  DialogChannelManager._internal() {
    geaLog.debug("$tag._internal");

    _broadCast = StreamController.broadcast();

    _getChannel(ChannelType.dialog).setMethodCallHandler(DialogChannelHandler(_broadCast).handleMethod);
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
      await _getChannel(ChannelType.dialog).invokeMethod(DialogChannelProfile.F2N_DIRECT_IS_RUNNING_ON_NATIVE, null);
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
      await _getChannel(ChannelType.dialog).invokeMethod(DialogChannelProfile.F2N_DIRECT_READY_TO_SERVICE, null);
    }
    on MissingPluginException {
      geaLog.debug("$tag:There is no \"READY_TO_SERVICE\" method");
    }
    on PlatformException {
      geaLog.debug("$tag:PlatformException!!!");
    }
  }
}