// file: wifi_network_request.dart
// date: Feb/21/2022
// brief: wifi network request entity
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class WifiNetworkRequest {
  String? ssid;
  String? password;
  String? type;

  WifiNetworkRequest({this.ssid, this.password, this.type});

  WifiNetworkRequest.fromJson(Map<String, dynamic> json) {
    ssid = json['ssid'];
    password = json['password'];
    // type = json['type']; // not sending the security type
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ssid'] = this.ssid;
    data['password'] = this.password;
    data['type'] = this.type;
    return data;
  }
}