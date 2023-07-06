import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'channel_item.dart';

class CommissioningChannelHandler extends ChannelHandler {
  CommissioningChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('Commissioning Listener Method call [${call.method}](${call.arguments})');

    switch (call.method) {
      case CommissioningChannelProfile.LISTEN_APPLICATION_PROVISIONING_TOKEN_RESPONSE:
        streamController.add(
            CommissioningChannelItem(
                CommissioningChannelListenType.APPLICATION_PROVISIONING_TOKEN,
                ResponseChannelDataItem(isSuccess: call.arguments['isSuccess'])));
        break;

      case CommissioningChannelProfile.LISTEN_CONNECTED_GE_MODULE_WIFI:
        streamController.add(
            CommissioningChannelItem(
                CommissioningChannelListenType.CONNECTED_GE_MODULE_WIFI,
                ResponseConnectedWifiDataItem(isSuccess: call.arguments['isSuccess'], reason: call.arguments['reason'])));
        break;

      case CommissioningChannelProfile.LISTEN_COMMISSIONING_DATA_RESPONSE:
        streamController.add(
            CommissioningChannelItem(
                CommissioningChannelListenType.COMMISSIONING_DATA_RESPONSE,
                ResponseChannelDataItem(isSuccess: call.arguments['isSuccess'])));
        break;

      case CommissioningChannelProfile.LISTEN_NETWORK_LIST:
        List<Map<String, String>> networkList = [];
        call.arguments.forEach((element) {
          networkList.add(Map.from(element));
        });
        streamController.add(
            CommissioningChannelItem(
                CommissioningChannelListenType.NETWORK_LIST,
                NetworkListChannelDataItem(networkList: networkList)));
        break;

      case CommissioningChannelProfile.LISTEN_PROGRESS_STEP:
        streamController.add(
            CommissioningChannelItem(
                CommissioningChannelListenType.PROGRESS_STEP,
                ProgressStepChannelDataItem(step: call.arguments['step'], isSuccess: call.arguments['isSuccess'])));
        break;

      case CommissioningChannelProfile.LISTEN_NETWORK_JOIN_STATUS_FAIL:
        streamController.add(
            CommissioningChannelItem(
                CommissioningChannelListenType.NETWORK_JOIN_STATUS_FAIL,
                ResponseChannelDataItem(isSuccess: false)));
        break;

      case CommissioningChannelProfile.LISTEN_CHECK_MODULE_STATUS_FROM_USER:
        streamController.add(
            CommissioningChannelItem(
                CommissioningChannelListenType.CHECK_MODULE_STATUS_FROM_USER,
                ResponseChannelDataItem(isSuccess: true)));
        break;

      default:
        throw MissingPluginException();
    }
  }
}
