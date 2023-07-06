import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/models/dialog/dialog_type.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class DialogChannelHandler extends ChannelHandler {
  DialogChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('Dialog Listener Method call [${call.method}](${call.arguments})');

    switch (call.method) {
      case DialogChannelProfile.N2F_DIRECT_SHOW_DIALOG:

        DialogType? dialogType;
        if (call.arguments['dialogName'] != null) {
          dialogType = DialogType.getTypeFrom(name: call.arguments['dialogName']);
        }

        DialogParameter? dialogParameter;
        if (call.arguments['dialogParameter'] != null) {
          Map<String, dynamic> param = {...call.arguments['dialogParameter']};
          dialogParameter = DialogParameter.fromJson(param);
        }

        streamController.add(
            DialogChannelItem(
                DialogChannelListenType.showDialog,
                DialogChannelDataItem(
                    dialogType: dialogType,
                    dialogParameter: dialogParameter)));
        break;

      case DialogChannelProfile.N2F_DIRECT_CLOSE_DIALOG:
        streamController.add(
            DialogChannelItem(
                DialogChannelListenType.closeDialog, null));
        break;

      default:
        throw MissingPluginException();
    }
  }

}