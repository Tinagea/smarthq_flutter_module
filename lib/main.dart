import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smarthq_flutter_module/constants/constants.dart';
import 'package:smarthq_flutter_module/dialog_home.dart';
import 'package:smarthq_flutter_module/entry_point.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/environment/device_environment.dart';

import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/main_home.dart';
import 'package:smarthq_flutter_module/view/common/global_cubit_observer.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';


void main() async => runAppWith(EntryPointType.main);

@pragma('vm:entry-point')
void dialog() async => runAppWith(EntryPointType.dialog);



void runAppWith(EntryPointType entryPointType) async {
  geaLog.debug("runAppWith($entryPointType) - started");

  /// Set the environment of the app.
  WidgetsFlutterBinding.ensureInitialized();
  final channelManager = ChannelManager(entryPointType);

  DeviceEnvironment();
  BuildEnvironment.initialize(
      channelManager: channelManager,
      buildType: BuildType.field,
      routingType: RoutingType.commissioning,
      restApiDataType: CommunicationDataType.cloud);

  AppDIs.dependencyInjection(
    entryPointType: entryPointType,
    channelManager: channelManager
  );

  await CertificateManager().load();
  await TestManager(entryPointType: entryPointType).initialize();

  if (entryPointType == EntryPointType.main) {
    channelManager.readyToService();
  }

  Bloc.observer = GlobalCubitObserver();

  /// Start to run the app.
  switch(entryPointType) {
    case EntryPointType.main:
      runApp(MainHome());
      break;
    case EntryPointType.dialog:
      runApp(DialogHome());
      break;
  }

  geaLog.debug("runAppWith($entryPointType) - end");
}
