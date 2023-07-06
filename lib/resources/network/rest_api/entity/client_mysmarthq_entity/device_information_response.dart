// file: device_information_response.dart
// date: Nov/25/2021
// brief: Device information response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/common/web_socket_pub_sub_services_response.dart';

class DeviceInformationResponse {
  String? kind;
  String? deviceId;
  String? deviceType;
  String? presence;
  String? lastSyncTime;
  String? lastPresenceTime;
  String? createdDateTime;
  List<Services>? services;
  bool? removable;
  String? adapterId;
  String? gatewayId;
  String? room;
  String? manufacturer;
  String? macAddress;
  String? nickname;
  String? icon;
  String? model;
  String? updId;
  List<String>? alertTypes;
  String? connectionType;
  String? userId;
  String? serial;

  DeviceInformationResponse(
      {this.kind,
        this.deviceId,
        this.deviceType,
        this.presence,
        this.lastSyncTime,
        this.lastPresenceTime,
        this.createdDateTime,
        this.services,
        this.removable,
        this.adapterId,
        this.gatewayId,
        this.room,
        this.manufacturer,
        this.macAddress,
        this.nickname,
        this.icon,
        this.model,
        this.updId,
        this.alertTypes,
        this.connectionType,
        this.userId,
        this.serial});

  DeviceInformationResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    deviceId = json['deviceId'];
    deviceType = json['deviceType'];
    presence = json['presence'];
    lastSyncTime = json['lastSyncTime'];
    lastPresenceTime = json['lastPresenceTime'];
    createdDateTime = json['createdDateTime'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
    removable = json['removable'];
    adapterId = json['adapterId'];
    gatewayId = json['gatewayId'];
    room = json['room'];
    manufacturer = json['manufacturer'];
    macAddress = json['macAddress'];
    nickname = json['nickname'];
    icon = json['icon'];
    model = json['model'];
    updId = json['updId'];
    alertTypes = json['alertTypes'] != null ? json['alertTypes'].cast<String>() : null;
    connectionType = json['connectionType'];
    userId = json['userId'];
    serial = json['serial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['deviceId'] = this.deviceId;
    data['deviceType'] = this.deviceType;
    data['presence'] = this.presence;
    data['lastSyncTime'] = this.lastSyncTime;
    data['lastPresenceTime'] = this.lastPresenceTime;
    data['createdDateTime'] = this.createdDateTime;
    if (this.services != null) {
      data['services'] = this.services?.map((v) => v.toJson()).toList();
    }
    data['removable'] = this.removable;
    data['adapterId'] = this.adapterId;
    data['gatewayId'] = this.gatewayId;
    data['room'] = this.room;
    data['manufacturer'] = this.manufacturer;
    data['macAddress'] = this.macAddress;
    data['nickname'] = this.nickname;
    data['icon'] = this.icon;
    data['model'] = this.model;
    data['updId'] = this.updId;
    data['alertTypes'] = this.alertTypes;
    data['connectionType'] = this.connectionType;
    data['userId'] = this.userId;
    data['serial'] = this.serial;
    return data;
  }
}

