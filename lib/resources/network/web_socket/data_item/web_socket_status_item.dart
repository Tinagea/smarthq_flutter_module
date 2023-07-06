// file: web_socket_status_item.dart
// date: Jun/20/2022
// brief: WebSocket status item.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


import 'package:smarthq_flutter_module/resources/network/web_socket/data_item/web_socket_data_item.dart';

enum WebSocketStateType {
  webSocketConnected,
  webSocketRefreshed,
  webSocketReadyToService,
  webSocketReceivedCache,
  webSocketReceivedErd,
  webSocketReceivedPublishErd,
  webSocketAppliancePresence,
  webSocketApplianceProvision,
  webSocketReceivedPong,
  webSocketReceivedPostErdSuccess,

  webSocketReadyToSubscribe,
  webSocketReceivedApplianceState,
  webSocketReceivedDeviceList,
  webSocketReceivedSecondsRemaining,

  /// For SmartHQ Data Model
  webSocketReceivedPubSubDevice,
  webSocketReceivedPubSubService,
  webSocketReceivedPubSubPresence,
  webSocketReceivedPubSubCommand
}

class WebSocketStateItem {
  final String? deviceId;
  final WebSocketStateType? type;
  final WebSocketDataItem? dataItem;
  const WebSocketStateItem({this.deviceId, this.type, this.dataItem});
}
