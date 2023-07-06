

import 'web_socket_pub_sub_config_response.dart';
import 'web_socket_pub_sub_state_response.dart';

class Services {
  String? serviceType;
  String? lastSyncTime;
  String? domainType;
  String? serviceDeviceType;
  State? state;
  String? serviceId;
  Config? config;
  List<String>? supportedCommands;
  String? lastStateTime;

  Services(
      {this.serviceType,
        this.lastSyncTime,
        this.domainType,
        this.serviceDeviceType,
        this.state,
        this.serviceId,
        this.config,
        this.supportedCommands,
        this.lastStateTime});

  Services.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    lastSyncTime = json['lastSyncTime'];
    domainType = json['domainType'];
    serviceDeviceType = json['serviceDeviceType'];
    state = json['state'] != null ? State.fromJson(json['state']) : null;
    serviceId = json['serviceId'];
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
    supportedCommands = json['supportedCommands'] != null ? json['supportedCommands'].cast<String>() : null;
    lastStateTime = json['lastStateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['serviceType'] = this.serviceType;
    data['lastSyncTime'] = this.lastSyncTime;
    data['domainType'] = this.domainType;
    data['serviceDeviceType'] = this.serviceDeviceType;
    if (this.state != null) {
      data['state'] = this.state?.toJson();
    }
    data['serviceId'] = this.serviceId;
    if (this.config != null) {
      data['config'] = this.config?.toJson();
    }
    data['supportedCommands'] = this.supportedCommands;
    data['lastStateTime'] = this.lastStateTime;
    return data;
  }
}