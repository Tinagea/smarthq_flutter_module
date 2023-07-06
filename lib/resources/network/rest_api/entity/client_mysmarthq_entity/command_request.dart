// file: command_request.dart
// date: Dec/13/2021
// brief: Command Request Entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

class CommandRequest {
  String? kind;
  String? deviceId;
  String? serviceType;
  String? domainType;
  String? serviceDeviceType;
  Command? command;

  CommandRequest(
      {this.kind,
        this.deviceId,
        this.serviceType,
        this.domainType,
        this.serviceDeviceType,
        this.command});

  CommandRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    deviceId = json['deviceId'];
    serviceType = json['serviceType'];
    domainType = json['domainType'];
    serviceDeviceType = json['serviceDeviceType'];
    command =
    json['command'] != null ? new Command.fromJson(json['command']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['deviceId'] = this.deviceId;
    data['serviceType'] = this.serviceType;
    data['domainType'] = this.domainType;
    data['serviceDeviceType'] = this.serviceDeviceType;
    if (this.command != null) {
      data['command'] = this.command?.toJson();
    }
    return data;
  }
}

class Command {
  String? commandType;
  bool? on;

  Command({this.commandType, this.on});

  Command.fromJson(Map<String, dynamic> json) {
    commandType = json['commandType'];
    on = json['on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commandType'] = this.commandType;
    if (this.on != null) {
      data['on'] = this.on;
    }
    return data;
  }
}
