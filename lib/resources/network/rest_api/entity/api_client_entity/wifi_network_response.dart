// file: wifi_network_response.dart
// date: Feb/21/2022
// brief: wifi network response entity
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class WifiNetworkResponse {
  String? networkId;

  WifiNetworkResponse({this.networkId});

  WifiNetworkResponse.fromJson(Map<String, dynamic> json) {
    networkId = json['networkId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['networkId'] = this.networkId;
    return data;
  }
}