import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/channels/channel_item.dart';

class NativeChannelHandler extends ChannelHandler {
  NativeChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('Native Listener Method call [${call.method}](${call.arguments})');

    switch (call.method) {
      case NativeChannelProfile.N2F_DIRECT_START_SERVICE:
        streamController.add(
            NativeChannelItem(
                NativeChannelListenType.startService,
                null));
        break;

      case NativeChannelProfile.N2F_DIRECT_POST_PUSH_TOKEN:
        streamController.add(
            NativeChannelItem(
                NativeChannelListenType.postPushToken,
                PushTokenChannelDataItem(
                    pushToken: call.arguments['pushToken'],
                    isLogin: call.arguments['login'])));
        break;

      case NativeChannelProfile.N2F_DIRECT_ROUTE_TO_SCREEN:

        RoutingType? routingType;
        if (call.arguments['routingName'] != null) {
          routingType = RoutingType.getTypeFrom(name: call.arguments['routingName']);
        }

        RoutingParameter? routingParameter;
        if (call.arguments['routingParameter'] != null) {
          Map<String, dynamic> param = {...call.arguments['routingParameter']};
          routingParameter = RoutingParameter.fromJson(param);
        }

        streamController.add(
            NativeChannelItem(
                NativeChannelListenType.routeToScreen,
                RoutingScreenChannelDataItem(
                    routingType: routingType,
                    routingParameter: routingParameter)));
        break;

      default:
        throw MissingPluginException();
    }

    return {"success":true};
  }

}