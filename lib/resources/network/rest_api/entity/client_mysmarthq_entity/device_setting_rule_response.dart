// file: device_setting_rule_response.dart
// date: Aug/29/2022
// brief: Device Setting Rule Response
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class DeviceSettingRuleResponse {
  String? kind;
  bool? ruleEnabled;

  DeviceSettingRuleResponse({this.kind, this.ruleEnabled});

  DeviceSettingRuleResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    ruleEnabled = json['ruleEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['ruleEnabled'] = this.ruleEnabled;
    return data;
  }
}