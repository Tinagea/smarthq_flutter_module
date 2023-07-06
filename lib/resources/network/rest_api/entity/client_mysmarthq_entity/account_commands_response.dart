
class AccountCommandsResponse {
  int? perpage;
  int? total;
  String? kind;
  int? page;
  List<Commands>? commands;

  AccountCommandsResponse(
      {this.perpage, this.total, this.kind, this.page, this.commands});

  AccountCommandsResponse.fromJson(Map<String, dynamic> json) {
    perpage = json['perpage'];
    total = json['total'];
    kind = json['kind'];
    page = json['page'];
    if (json['commands'] != null) {
      commands = <Commands>[];
      json['commands'].forEach((v) {
        commands!.add(new Commands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perpage'] = this.perpage;
    data['total'] = this.total;
    data['kind'] = this.kind;
    data['page'] = this.page;
    if (this.commands != null) {
      data['commands'] = this.commands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commands {
  String? serviceType;
  String? domainType;
  String? appId;
  String? correlationId;
  String? serviceDeviceType;
  String? commandDateTime;
  Rule? rule;
  Command? command;

  Commands(
      {this.serviceType,
        this.domainType,
        this.appId,
        this.correlationId,
        this.serviceDeviceType,
        this.commandDateTime,
        this.rule,
        this.command});

  Commands.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    domainType = json['domainType'];
    appId = json['appId'];
    correlationId = json['correlationId'];
    serviceDeviceType = json['serviceDeviceType'];
    commandDateTime = json['commandDateTime'];
    rule = json['rule'] != null ? new Rule.fromJson(json['rule']) : null;
    command =
    json['command'] != null ? new Command.fromJson(json['command']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceType'] = this.serviceType;
    data['domainType'] = this.domainType;
    data['appId'] = this.appId;
    data['correlationId'] = this.correlationId;
    data['serviceDeviceType'] = this.serviceDeviceType;
    data['commandDateTime'] = this.commandDateTime;
    if (this.rule != null) {
      data['rule'] = this.rule!.toJson();
    }
    if (this.command != null) {
      data['command'] = this.command!.toJson();
    }
    return data;
  }
}

class Rule {
  String? deviceType;
  String? alertType;
  String? ruleId;
  String? deviceId;

  Rule({this.deviceType, this.alertType, this.ruleId, this.deviceId});

  Rule.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    alertType = json['alertType'];
    ruleId = json['ruleId'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceType'] = this.deviceType;
    data['alertType'] = this.alertType;
    data['ruleId'] = this.ruleId;
    data['deviceId'] = this.deviceId;
    return data;
  }
}

class Command {
  String? commandType;
  String? pushText;
  String? pushTitle;

  Command({this.commandType, this.pushText});

  Command.fromJson(Map<String, dynamic> json) {
    commandType = json['commandType'];
    pushText = json['pushText'];
    pushTitle = json['pushTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commandType'] = this.commandType;
    data['pushText'] = this.pushText;
    data['pushTitle'] = this.pushTitle;
    return data;
  }
}

