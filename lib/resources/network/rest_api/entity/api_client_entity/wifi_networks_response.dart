// file: wifi_networks_response.dart
// date: Feb/21/2022
// brief: wifi networks response entity
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class WifiNetworksResponse {
  String? kind;
  List<Networks>? networks;

  WifiNetworksResponse(
      {this.kind,
        this.networks});

  WifiNetworksResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    if (json['networks'] != null) {
      networks = [];
      json['networks'].forEach((v) {
        networks?.add(new Networks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.networks != null) {
      data['networks'] = this.networks?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Networks {
  String? password;
  String? networkId;
  String? ssid;
  String? type;

  Networks({this.password, this.networkId, this.ssid, this.type});

  Networks.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    networkId = json['networkId'];
    ssid = json['ssid'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['password'] = this.password;
    data['networkId'] = this.networkId;
    data['ssid'] = this.ssid;
    data['type'] = this.type;
    return data;
  }
}