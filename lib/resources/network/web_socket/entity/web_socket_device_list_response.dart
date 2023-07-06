// file: web_socket_device_list_response.dart
// date: Jun/20/2022
// brief: WebSocket device list response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketDeviceListResponse {
  String? kind;
  String? id;
  Request? request;
  bool? success;
  int? code;
  Body? body;

  WebSocketDeviceListResponse(
      {this.kind, this.id, this.request, this.success, this.code, this.body});

  WebSocketDeviceListResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'];
    request =
    json['request'] != null ? Request.fromJson(json['request']) : null;
    success = json['success'];
    code = json['code'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['id'] = this.id;
    if (this.request != null) {
      data['request'] = this.request?.toJson();
    }
    data['success'] = this.success;
    data['code'] = this.code;
    if (this.body != null) {
      data['body'] = this.body?.toJson();
    }
    return data;
  }
}

class Request {
  String? host;
  String? method;
  String? path;

  Request({this.host, this.method, this.path});

  Request.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    method = json['method'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['host'] = this.host;
    data['method'] = this.method;
    data['path'] = this.path;
    return data;
  }
}

class Body {
  String? kind;
  List<Devices>? devices;

  Body({this.kind, this.devices});

  Body.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    if (json['devices'] != null) {
      devices = [];
      json['devices'].forEach((v) {
        devices?.add(new Devices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.devices != null) {
      data['devices'] = this.devices?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Devices {
  String? createdDateTime;
  String? deviceId;
  String? deviceType;
  String? gatewayId;
  String? lastSyncTime;
  String? lastPresenceTime;
  String? presence;
  String? nickname;
  String? icon;

  Devices(
      {this.createdDateTime,
        this.deviceId,
        this.deviceType,
        this.gatewayId,
        this.lastSyncTime,
        this.lastPresenceTime,
        this.presence,
        this.nickname,
        this.icon});

  Devices.fromJson(Map<String, dynamic> json) {
    createdDateTime = json['createdDateTime'];
    deviceId = json['deviceId'];
    deviceType = json['deviceType'];
    gatewayId = json['gatewayId'];
    lastSyncTime = json['lastSyncTime'];
    lastPresenceTime = json['lastPresenceTime'];
    presence = json['presence'];
    nickname = json['nickname'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdDateTime'] = this.createdDateTime;
    data['deviceId'] = this.deviceId;
    data['deviceType'] = this.deviceType;
    data['gatewayId'] = this.gatewayId;
    data['lastSyncTime'] = this.lastSyncTime;
    data['lastPresenceTime'] = this.lastPresenceTime;
    data['presence'] = this.presence;
    data['nickname'] = this.nickname;
    data['icon'] = this.icon;
    return data;
  }
}