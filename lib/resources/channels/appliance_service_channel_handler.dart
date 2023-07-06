import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ApplianceServiceChannelHandler extends ChannelHandler {
  ApplianceServiceChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('ApplianceService Listener Method call [${call.method}](${call.arguments})');

    switch (call.method) {
      // case ApplianceServiceChannelProfile.N2F_START_SERVICE:
        // streamController.add(
        //     NativeChannelItem(
        //         NativeChannelListenType.startService, null));
        // break;

      default:
        throw MissingPluginException();
    }
  }

}