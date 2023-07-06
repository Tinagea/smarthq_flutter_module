// file: web_socket_pub_sub_service_response.dart
// date: Jan/05/2023
// brief: WebSocket pub sub service response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'common/web_socket_pub_sub_state_response.dart';
import 'common/web_socket_pub_sub_config_response.dart';

class WebSocketPubSubServiceResponse {
  String? serviceType;
  String? deviceType;
  String? updId;
  String? lastSyncTime;
  String? domainType;
  String? kind;
  String? deviceId;
  String? macAddress;
  String? serial;
  String? model;
  String? adapterId;
  State? state;
  String? serviceId;
  String? serviceDeviceType;
  Config? config;
  String? lastStateTime;
  State? statePrevious;

  WebSocketPubSubServiceResponse(
      {this.serviceType,
        this.deviceType,
        this.updId,
        this.lastSyncTime,
        this.domainType,
        this.kind,
        this.deviceId,
        this.macAddress,
        this.serial,
        this.model,
        this.adapterId,
        this.state,
        this.serviceId,
        this.serviceDeviceType,
        this.config,
        this.lastStateTime,
        this.statePrevious});

  WebSocketPubSubServiceResponse.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    deviceType = json['deviceType'];
    updId = json['updId'];
    lastSyncTime = json['lastSyncTime'];
    domainType = json['domainType'];
    kind = json['kind'];
    deviceId = json['deviceId'];
    macAddress = json['macAddress'];
    serial = json['serial'];
    model = json['model'];
    adapterId = json['adapterId'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    serviceId = json['serviceId'];
    serviceDeviceType = json['serviceDeviceType'];
    config =
    json['config'] != null ? new Config.fromJson(json['config']) : null;
    lastStateTime = json['lastStateTime'];
    statePrevious = json['statePrevious'] != null
        ? new State.fromJson(json['statePrevious'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceType'] = this.serviceType;
    data['deviceType'] = this.deviceType;
    data['updId'] = this.updId;
    data['lastSyncTime'] = this.lastSyncTime;
    data['domainType'] = this.domainType;
    data['kind'] = this.kind;
    data['deviceId'] = this.deviceId;
    data['macAddress'] = this.macAddress;
    data['serial'] = this.serial;
    data['model'] = this.model;
    data['adapterId'] = this.adapterId;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    data['serviceId'] = this.serviceId;
    data['serviceDeviceType'] = this.serviceDeviceType;
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    data['lastStateTime'] = this.lastStateTime;
    if (this.statePrevious != null) {
      data['statePrevious'] = this.statePrevious!.toJson();
    }
    return data;
  }
}
