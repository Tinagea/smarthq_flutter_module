
import 'package:smarthq_flutter_module/models/dialog/dialog_type.dart';
import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';

abstract class ChannelDataItem {
  const ChannelDataItem();
}

class ApplianceTypeChannelDataItem implements ChannelDataItem {
  final String? type;

  const ApplianceTypeChannelDataItem({this.type});
}

class ResponseChannelDataItem implements ChannelDataItem {
  final bool? isSuccess;

  const ResponseChannelDataItem({this.isSuccess});
}

class ResponseConnectedWifiDataItem implements ChannelDataItem {
  final bool? isSuccess;
  final int? reason;

  const ResponseConnectedWifiDataItem({this.isSuccess, this.reason});
}

class NetworkListChannelDataItem implements ChannelDataItem {
  final List<Map<String, String>>? networkList;

  const NetworkListChannelDataItem({this.networkList});
}

class ProgressStepChannelDataItem implements ChannelDataItem {
  final int? step;
  final bool? isSuccess;

  const ProgressStepChannelDataItem({this.step, this.isSuccess});
}

class ApplianceTypesChannelDataItem implements ChannelDataItem {
  final List<String>? applianceErds;

  const ApplianceTypesChannelDataItem({this.applianceErds});
}

class StartPairingActionResultChannelDataItem implements ChannelDataItem {
  final String? applianceErd;
  final bool? isSuccess;

  const StartPairingActionResultChannelDataItem({this.applianceErd, this.isSuccess});
}

class BleStateChannelDataItem implements ChannelDataItem {
  final String? state;

  const BleStateChannelDataItem({this.state});
}

class BleMovePairSensorPageChannelDataItem implements ChannelDataItem {
  final String? deviceId;
  final String? gatewayId;

  const BleMovePairSensorPageChannelDataItem({this.deviceId, this.gatewayId});
}

class DetectedScanningChannelDataItem implements ChannelDataItem {
  final String? scanType;
  final int? advertisementIndex;
  final String? applianceType;

  const DetectedScanningChannelDataItem({this.scanType, this.advertisementIndex, this.applianceType});
}

class PushTokenChannelDataItem implements ChannelDataItem {
  final String? pushToken;
  final bool? isLogin;

  const PushTokenChannelDataItem({this.pushToken, this.isLogin});
}

class RoutingScreenChannelDataItem implements ChannelDataItem {
  final RoutingType? routingType;
  final RoutingParameter? routingParameter;

  const RoutingScreenChannelDataItem({this.routingType, this.routingParameter});
}

class DialogChannelDataItem implements ChannelDataItem {
  final DialogType? dialogType;
  final DialogParameter? dialogParameter;

  const DialogChannelDataItem({this.dialogType, this.dialogParameter});
}

class AllShortcutsDataItem implements ChannelDataItem {
  final String? allShortcuts;

  const AllShortcutsDataItem({this.allShortcuts});
}
