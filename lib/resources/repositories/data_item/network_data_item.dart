// file: network_data_item.dart
// date: Jun/14/2021
// brief: A class for network data item.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

class NetworkDataItem {
  int? id;
  String? networkId;
  String? ssid;
  String? password;
  String? securityType;

  NetworkDataItem({
    this.id,
    this.networkId,
    this.ssid,
    this.password,
    this.securityType
  });

  NetworkDataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    networkId = json['network_id'];
    ssid = json['ssid'];
    password = json['password'];
    securityType = json['security_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['network_id'] = this.networkId;
    data['ssid'] = this.ssid;
    data['password'] = this.password;
    data['security_type'] = this.securityType;
    return data;
  }

}

class NetworkListDataItem {
  List<NetworkDataItem>? networks;

  NetworkListDataItem({
    this.networks
  });

  NetworkListDataItem.fromJson(Map<String, dynamic> json) {
    if (json['networks'] != null) {
      networks = [];
      json['networks'].forEach((v) {
        networks?.add(new NetworkDataItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.networks != null) {
      data['networks'] = this.networks?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}