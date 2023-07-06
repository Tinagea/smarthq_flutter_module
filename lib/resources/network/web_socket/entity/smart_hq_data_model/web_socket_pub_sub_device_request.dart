// file: web_socket_pub_sub_device_request.dart
// date: Jun/20/2022
// brief: WebSocket pub sub device request entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketPubSubDeviceRequest {
  String? kind;
  String? action;
  String? deviceId;
  bool? pubsub;
  bool? services;
  bool? presence;
  bool? alerts;
  bool? commands;

  WebSocketPubSubDeviceRequest(
      {this.kind,
        this.action,
        this.deviceId,
        this.pubsub,
        this.services,
        this.presence,
        this.alerts,
        this. commands});

  WebSocketPubSubDeviceRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    action = json['action'];
    deviceId = json['deviceId'];
    services = json['services'];
    pubsub = json['pubsub'];
    presence = json['presence'];
    alerts = json['alerts'];
    commands = json['commands'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['action'] = this.action;
    data['deviceId'] = this.deviceId;
    data['services'] = this.services;
    data['pubsub'] = this.pubsub;
    data['presence'] = this.presence;
    data['alerts'] = this.alerts;
    data['commands'] = this.commands;
    return data;
  }
}