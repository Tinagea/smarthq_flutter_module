// file: appliance_list_response.dart
// date: Oct/21/2022
// brief: App responses v1/appliance
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'dart:convert';

class ApplianceListResponse {
  String? kind;
  String? userId;
  List<ApplianceListItem>? items;

  ApplianceListResponse(
      this.kind,
      this.userId,
      this.items
      );

  factory ApplianceListResponse.fromRawJson(String str) => ApplianceListResponse.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  ApplianceListResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    userId = json['userId'];
    if (json['items'] != null) {
      items = <ApplianceListItem>[];
      json['items'].forEach((v) {
        items!.add(ApplianceListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['userId'] = this.userId;
    if (this.items != null) {
      data['items'] =
          this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApplianceListItem {
  String? applianceId;
  String? type;
  String? brand;
  String? jid;
  String? nickname;
  String? online;

  ApplianceListItem ({
    this.applianceId,
    this.type,
    this.brand,
    this.jid,
    this.nickname,
    this.online
  });

  factory ApplianceListItem.fromRawJson(String str) => ApplianceListItem.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  ApplianceListItem.fromJson(Map<String, dynamic> json) {
    applianceId = json['applianceId'];
    type = json['type'];
    brand = json['brand'];
    jid = json['jid'];
    nickname = json['nickname'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['applianceId'] = this.applianceId;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['jid'] = this.jid;
    data['nickname'] = this.nickname;
    data['online'] = this.online;
    return data;
  }
}