// file: web_socket_pub_sub_device_request.dart
// date: Jun/20/2022
// brief: WebSocket pub sub device request entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketPubSubDeviceRequest {
  String? kind;
  String? action;
  String? deviceId;
  bool? services;
  bool? presence;
  bool? alerts;

  WebSocketPubSubDeviceRequest(
      {this.kind,
        this.action,
        this.deviceId,
        this.services,
        this.presence,
        this.alerts});

  WebSocketPubSubDeviceRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    action = json['action'];
    deviceId = json['deviceId'];
    services = json['services'];
    presence = json['presence'];
    alerts = json['alerts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['action'] = this.action;
    data['deviceId'] = this.deviceId;
    data['services'] = this.services;
    data['presence'] = this.presence;
    data['alerts'] = this.alerts;
    return data;
  }
}