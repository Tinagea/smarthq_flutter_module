// file: device_list_response.dart
// date: Nov/25/2021
// brief: device list response entity
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

enum DevicePresence {
  online,
  offline,
}

class DeviceListResponse {
  int? perpage;
  int? total;
  List<Devices>? devices;
  String? kind;
  int? page;
  String? userId;

  DeviceListResponse(
      {this.perpage,
        this.total,
        this.devices,
        this.kind,
        this.page,
        this.userId});

  DeviceListResponse.fromJson(Map<String, dynamic> json) {
    perpage = json['perpage'];
    total = json['total'];
    if (json['devices'] != null) {
      devices = [];
      json['devices'].forEach((v) {
        devices?.add(new Devices.fromJson(v));
      });
    }
    kind = json['kind'];
    page = json['page'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perpage'] = this.perpage;
    data['total'] = this.total;
    if (this.devices != null) {
      data['devices'] = this.devices?.map((v) => v.toJson()).toList();
    }
    data['kind'] = this.kind;
    data['page'] = this.page;
    data['userId'] = this.userId;
    return data;
  }
}

class Devices {
  String? deviceType;
  String? updId;
  String? lastSyncTime;
  String? icon;
  String? createdDateTime;
  String? deviceId;
  String? building;
  String? unit;
  String? macAddress;
  String? serial;
  String? lastPresenceTime;
  String? nickname;
  String? location;
  String? model;
  String? floor;
  DevicePresence? presence;
  String? gatewayId;
  String? productName;
  String? manufacturer;
  String? adapterId;
  String? brand;


  Devices(
      {this.deviceType,
        this.updId,
        this.lastSyncTime,
        this.icon,
        this.createdDateTime,
        this.deviceId,
        this.building,
        this.unit,
        this.macAddress,
        this.serial,
        this.lastPresenceTime,
        this.nickname,
        this.location,
        this.model,
        this.floor,
        this.presence,
        this.gatewayId,
        this.productName,
        this.manufacturer,
        this.adapterId,
        this.brand});

  Devices.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    updId = json['updId'];
    lastSyncTime = json['lastSyncTime'];
    icon = json['icon'];
    createdDateTime = json['createdDateTime'];
    deviceId = json['deviceId'];
    building = json['building'];
    unit = json['unit'];
    macAddress = json['macAddress'];
    serial = json['serial'];
    lastPresenceTime = json['lastPresenceTime'];
    nickname = json['nickname'];
    location = json['location'];
    model = json['model'];
    floor = json['floor'];
    presence = DevicePresence.offline;
    if (json['presence'] == 'ONLINE') {
      presence = DevicePresence.online;
    }
    gatewayId = json['gatewayId'];
    productName = json['productName'];
    manufacturer = json['manufacturer'];
    adapterId = json['adapterId'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceType'] = this.deviceType;
    data['updId'] = this.updId;
    data['lastSyncTime'] = this.lastSyncTime;
    data['icon'] = this.icon;
    data['createdDateTime'] = this.createdDateTime;
    data['deviceId'] = this.deviceId;
    data['building'] = this.building;
    data['unit'] = this.unit;
    data['macAddress'] = this.macAddress;
    data['serial'] = this.serial;
    data['lastPresenceTime'] = this.lastPresenceTime;
    data['nickname'] = this.nickname;
    data['location'] = this.location;
    data['model'] = this.model;
    data['floor'] = this.floor;
    data['presence'] = this.presence;
    data['gatewayId'] = this.gatewayId;
    data['productName'] = this.productName;
    data['manufacturer'] = this.manufacturer;
    data['adapterId'] = this.adapterId;
    data['brand'] = this.brand;
    return data;
  }
}