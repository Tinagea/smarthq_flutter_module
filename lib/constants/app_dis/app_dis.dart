import 'package:smarthq_flutter_module/constants/app_dis/app_dialog_dis.dart';
import 'package:smarthq_flutter_module/constants/app_dis/app_main_dis.dart';
import 'package:smarthq_flutter_module/entry_point.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';


abstract class AppDIs {
  static const String tag = "AppDIs:";

  static void dependencyInjection({
    required EntryPointType entryPointType,
    required ChannelManager channelManager}) {
    geaLog.debug("$tag:dependencyInjection()");

    switch (entryPointType) {
      case EntryPointType.main:
        AppMainDIs.dependencyInjection(channelManager: channelManager);
        break;

      case EntryPointType.dialog:
        AppDialogDIs.dependencyInjection(channelManager: channelManager);
        break;
    }
  }
}