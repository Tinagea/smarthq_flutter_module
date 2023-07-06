// file: device_setting_response.dart
// date: Aug/29/2022
// brief: Device Setting Response
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class DeviceSettingResponse {
  String? kind;
  List<Settings>? settings;

  DeviceSettingResponse({this.kind, this.settings});

  DeviceSettingResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    if (json['settings'] != null) {
      settings = <Settings>[];
      json['settings'].forEach((v) {
        settings!.add(Settings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.settings != null) {
      data['settings'] = this.settings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  String? ruleId;
  String? title;
  String? description;
  bool? ruleEnabled;

  Settings({this.ruleId, this.title, this.description, this.ruleEnabled});

  Settings.fromJson(Map<String, dynamic> json) {
    ruleId = json['ruleId'];
    title = json['title'];
    description = json['description'];
    ruleEnabled = json['ruleEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ruleId'] = this.ruleId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['ruleEnabled'] = this.ruleEnabled;
    return data;
  }
}