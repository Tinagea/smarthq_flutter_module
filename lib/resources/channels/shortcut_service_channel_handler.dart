import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_result/shortcut_service_result.dart';
import 'package:smarthq_flutter_module/resources/repositories/shortcut_service_repository.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ShortcutServiceChannelHandler extends ChannelHandler {
  ShortcutServiceChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('ShortcutService Listener Method call [${call.method}](${call.arguments})');
    final shortcutServiceRepository = GetIt.I.get<ShortcutServiceRepository>();

    switch (call.method) {
      case ShortcutServiceChannelProfile.N2F_DIRECT_REQUEST_ALL_SHORTCUTS:
        final allShortcuts = await shortcutServiceRepository.fetchAllShortcuts();

        geaLog.debug('allShortcuts $allShortcuts');
        if (allShortcuts != null && allShortcuts.length > 0) {
          return ShortcutServiceResult(
              kind: "allShortcuts",
              success: true,
              body: allShortcuts
          ).toJson();
        } else {
          return ShortcutServiceResult(
              kind: "allShortcuts",
              success: false,
              reason: "no stored shortcut."
          ).toJson();
        }

      case ShortcutServiceChannelProfile.N2F_DIRECT_REQUEST_REMOVE_ALL_SHORTCUTS:
        shortcutServiceRepository.removeAllShortcuts();
        return;

      default:
        throw MissingPluginException();
    }
  }

}