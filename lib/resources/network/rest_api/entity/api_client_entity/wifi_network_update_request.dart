// file: wifi_network_update_request.dart
// date: Feb/21/2022
// brief: wifi network update request entity
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class WifiNetworkUpdateRequest {
  String? kind;
  String? ssid;
  String? password;

  WifiNetworkUpdateRequest({this.kind, this.ssid, this.password});

  WifiNetworkUpdateRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    ssid = json['ssid'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['ssid'] = this.ssid;
    data['password'] = this.password;
    return data;
  }
}