// // file: web_socket_pub_sub_service_response.dart
// // date: Jun/20/2022
// // brief: WebSocket pub sub service response entity.
// // Copyright GEAppliances, a Haier company (Confidential). All rights reserved.
//
//
// class WebSocketPubSubServiceResponse {
//   String? serviceType;
//   String? deviceType;
//   String? lastSyncTime;
//   String? domainType;
//   String? kind;
//   String? deviceId;
//   String? building;
//   String? macAddress;
//   String? unit;
//   String? serial;
//   String? location;
//   String? model;
//   String? adapterId;
//   State? state;
//   String? serviceId;
//   String? floor;
//   String? serviceDeviceType;
//   Config? config;
//   String? lastStateTime;
//
//   WebSocketPubSubServiceResponse(
//       {this.serviceType,
//         this.deviceType,
//         this.lastSyncTime,
//         this.domainType,
//         this.kind,
//         this.deviceId,
//         this.building,
//         this.macAddress,
//         this.unit,
//         this.serial,
//         this.location,
//         this.model,
//         this.adapterId,
//         this.state,
//         this.serviceId,
//         this.floor,
//         this.serviceDeviceType,
//         this.config,
//         this.lastStateTime});
//
//   WebSocketPubSubServiceResponse.fromJson(Map<String, dynamic> json) {
//     serviceType = json['serviceType'];
//     deviceType = json['deviceType'];
//     lastSyncTime = json['lastSyncTime'];
//     domainType = json['domainType'];
//     kind = json['kind'];
//     deviceId = json['deviceId'];
//     building = json['building'];
//     macAddress = json['macAddress'];
//     unit = json['unit'];
//     serial = json['serial'];
//     location = json['location'];
//     model = json['model'];
//     adapterId = json['adapterId'];
//     state = json['state'] != null ? State.fromJson(json['state']) : null;
//     serviceId = json['serviceId'];
//     floor = json['floor'];
//     serviceDeviceType = json['serviceDeviceType'];
//     config =
//     json['config'] != null ? Config.fromJson(json['config']) : null;
//     lastStateTime = json['lastStateTime'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['serviceType'] = this.serviceType;
//     data['deviceType'] = this.deviceType;
//     data['lastSyncTime'] = this.lastSyncTime;
//     data['domainType'] = this.domainType;
//     data['kind'] = this.kind;
//     data['deviceId'] = this.deviceId;
//     data['building'] = this.building;
//     data['macAddress'] = this.macAddress;
//     data['unit'] = this.unit;
//     data['serial'] = this.serial;
//     data['location'] = this.location;
//     data['model'] = this.model;
//     data['adapterId'] = this.adapterId;
//     if (this.state != null) {
//       data['state'] = this.state?.toJson();
//     }
//     data['serviceId'] = this.serviceId;
//     data['floor'] = this.floor;
//     data['serviceDeviceType'] = this.serviceDeviceType;
//     if (this.config != null) {
//       data['config'] = this.config?.toJson();
//     }
//     data['lastStateTime'] = this.lastStateTime;
//     return data;
//   }
// }
//
// class State {
//   String? selectedCycle;
//   String? phaseCloud;
//   bool? disabled;
//   int? sessionId;
//   String? phaseDevice;
//   int? secondsRemaining;
//
//   State(
//       {this.selectedCycle,
//         this.phaseCloud,
//         this.disabled,
//         this.sessionId,
//         this.phaseDevice,
//         this.secondsRemaining});
//
//   State.fromJson(Map<String, dynamic> json) {
//     selectedCycle = json['selectedCycle'];
//     phaseCloud = json['phaseCloud'];
//     disabled = json['disabled'];
//     sessionId = json['sessionId'];
//     phaseDevice = json['phaseDevice'];
//     secondsRemaining = json['secondsRemaining'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['selectedCycle'] = this.selectedCycle;
//     data['phaseCloud'] = this.phaseCloud;
//     data['disabled'] = this.disabled;
//     data['sessionId'] = this.sessionId;
//     data['phaseDevice'] = this.phaseDevice;
//     data['secondsRemaining'] = this.secondsRemaining;
//     return data;
//   }
// }
//
// class Config {
//   String? personality;
//
//   Config({this.personality});
//
//   Config.fromJson(Map<String, dynamic> json) {
//     personality = json['personality'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['personality'] = this.personality;
//     return data;
//   }
// }