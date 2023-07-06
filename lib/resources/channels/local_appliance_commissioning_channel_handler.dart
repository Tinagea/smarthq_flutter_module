import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/local_appliance_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'channel_item.dart';

class LocalApplianceCommissioningChannelHandler extends ChannelHandler {
  LocalApplianceCommissioningChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('Local Appliance Commissioning Listener Method call [${call.method}](${call.arguments})');

    switch (call.method) {
      case LocalApplianceCommissioningChannelProfile.LISTEN_TEST_SAMPLE:
        streamController.add(
            LocalApplianceCommissioningChannelItem(
                LocalApplianceCommissioningChannelListenType.testSample,
                ResponseChannelDataItem(
                    isSuccess: call.arguments['isSuccess'])));
        break;

      default:
        throw MissingPluginException();
    }
  }

}