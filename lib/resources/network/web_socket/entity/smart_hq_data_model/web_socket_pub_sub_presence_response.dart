// file: web_socket_pub_sub_presence_response.dart
// date: Jan/05/2023
// brief: WebSocket pub sub presence response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

class WebSocketPubSubPresenceResponse {
  String? adapterId;
  String? deviceId;
  String? deviceType;
  String? kind;
  String? lastSyncTime;
  String? macAddress;
  String? manufacturer;
  String? presence;
  String? updId;

  WebSocketPubSubPresenceResponse(
      {this.adapterId,
        this.deviceId,
        this.deviceType,
        this.kind,
        this.lastSyncTime,
        this.macAddress,
        this.manufacturer,
        this.presence,
        this.updId});

  WebSocketPubSubPresenceResponse.fromJson(Map<String, dynamic> json) {
    adapterId = json['adapterId'];
    deviceId = json['deviceId'];
    deviceType = json['deviceType'];
    kind = json['kind'];
    lastSyncTime = json['lastSyncTime'];
    macAddress = json['macAddress'];
    manufacturer = json['manufacturer'];
    presence = json['presence'];
    updId = json['updId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adapterId'] = this.adapterId;
    data['deviceId'] = this.deviceId;
    data['deviceType'] = this.deviceType;
    data['kind'] = this.kind;
    data['lastSyncTime'] = this.lastSyncTime;
    data['macAddress'] = this.macAddress;
    data['manufacturer'] = this.manufacturer;
    data['presence'] = this.presence;
    data['updId'] = this.updId;
    return data;
  }
}