// file: web_socket_pub_sub_device_response.dart
// date: Jan/05/2023
// brief: WebSocket pub sub device response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'common/web_socket_pub_sub_services_response.dart';

class WebSocketPubSubDeviceResponse {
  String? deviceType;
  String? updId;
  String? lastSyncTime;
  String? kind;
  String? icon;
  List<Services>? services;
  String? deviceId;
  String? macAddress;
  String? serial;
  bool? removable;
  String? nickname;
  String? model;
  String? adapterId;
  String? event;
  String? gatewayId;

  WebSocketPubSubDeviceResponse(
      {this.deviceType,
        this.updId,
        this.lastSyncTime,
        this.kind,
        this.icon,
        this.services,
        this.deviceId,
        this.macAddress,
        this.serial,
        this.removable,
        this.nickname,
        this.model,
        this.adapterId,
        this.event,
        this.gatewayId});

  WebSocketPubSubDeviceResponse.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    updId = json['updId'];
    lastSyncTime = json['lastSyncTime'];
    kind = json['kind'];
    icon = json['icon'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    deviceId = json['deviceId'];
    macAddress = json['macAddress'];
    serial = json['serial'];
    removable = json['removable'];
    nickname = json['nickname'];
    model = json['model'];
    adapterId = json['adapterId'];
    event = json['event'];
    gatewayId = json['gatewayId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceType'] = this.deviceType;
    data['updId'] = this.updId;
    data['lastSyncTime'] = this.lastSyncTime;
    data['kind'] = this.kind;
    data['icon'] = this.icon;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['deviceId'] = this.deviceId;
    data['macAddress'] = this.macAddress;
    data['serial'] = this.serial;
    data['removable'] = this.removable;
    data['nickname'] = this.nickname;
    data['model'] = this.model;
    data['adapterId'] = this.adapterId;
    data['event'] = this.event;
    data['gatewayId'] = this.gatewayId;
    return data;
  }
}