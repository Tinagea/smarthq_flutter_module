// file: web_socket_data_item.dart
// date: Jun/20/2022
// brief: WebSocket data item.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_device_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_presence_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_service_response.dart';

abstract class WebSocketDataItem {
  const WebSocketDataItem();
}

class WebSocketDataReasonItem implements WebSocketDataItem {
  final String? reason;

  const WebSocketDataReasonItem({this.reason});
}

class WebSocketDataPongItem implements WebSocketDataItem {
  final String? id;

  const WebSocketDataPongItem({this.id});
}

class WebSocketDataPresenceItem implements WebSocketDataItem {
  final String? jid;
  final String? presence;

  const WebSocketDataPresenceItem({this.jid, this.presence});
}

class WebSocketDataPublishErdItem implements WebSocketDataItem {
  final String? jid;
  final String? erdNumber;
  final String? erdValue;
  final String? timeStamp;

  const WebSocketDataPublishErdItem({this.jid, this.erdNumber, this.erdValue, this.timeStamp});
}

class WebSocketDataProvisionItem implements WebSocketDataItem {
  final String? jid;
  final String? status;

  const WebSocketDataProvisionItem({this.jid, this.status});
}

class WebSocketDataCacheItem implements WebSocketDataItem {
  final String? jid;
  final List<WebSocketErdData>? cache;

  const WebSocketDataCacheItem({this.jid, this.cache});
}

class WebSocketErdData {
  final String? erd;
  final String? value;
  final String? timestamp;

  const WebSocketErdData({this.erd, this.value, this.timestamp});
}

class WebSocketDataErdItem implements WebSocketDataItem {
  final String? jid;
  final String? erd;
  final String? value;

  const WebSocketDataErdItem({this.jid, this.erd, this.value});
}

class WebSocketDataPostErdItem implements WebSocketDataItem {
  final String? jid;
  final String? erd;
  final String? value;
  final String? status;

  const WebSocketDataPostErdItem({this.jid, this.erd, this.value, this.status});
}

class WebSocketDataSubscribeItem implements WebSocketDataItem {
  final bool? success;

  const WebSocketDataSubscribeItem({this.success});
}


enum WebSocketLaundryState {
  idle,
  reserved,
  authorized,
  denied,
  fault
}

enum WebSocketAppliancePhaseDevice {
  idle,
  reserved,
  authorized,
  cycleRequested,
  cycleStarted,
  paused,
  cancelled,
  denied,
  expired,
  fault
}

class WebSocketDataApplianceStateItem implements WebSocketDataItem {
  final int? sessionId;
  final String? deviceId;
  final WebSocketAppliancePhaseDevice? phaseDevice;
  final WebSocketLaundryState? state;

  const WebSocketDataApplianceStateItem({this.sessionId, this.deviceId, this.phaseDevice, this.state});
}

class WebSocketDeviceData {
  final String? deviceId;
  final String? deviceType;
  final String? nickname;

  const WebSocketDeviceData({this.deviceId, this.deviceType, this.nickname});
}

class WebSocketDataDeviceListItem implements WebSocketDataItem {
  final List<WebSocketDeviceData>? devices;

  const WebSocketDataDeviceListItem({this.devices});
}

class WebSocketDataSecondsRemainingItem implements WebSocketDataItem {
  final String? serviceId;
  final String? deviceId;
  final int? secondsRemaining;

  const WebSocketDataSecondsRemainingItem({this.serviceId, this.deviceId, this.secondsRemaining});
}

class WebSocketDataPubSubItem implements WebSocketDataItem {
  final WebSocketPubSubDeviceResponse? device;
  final WebSocketPubSubServiceResponse? service;
  final WebSocketPubSubPresenceResponse? presence;

  const WebSocketDataPubSubItem({this.device, this.service, this.presence});
}