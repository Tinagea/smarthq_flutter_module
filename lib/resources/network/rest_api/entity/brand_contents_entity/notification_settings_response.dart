// file: notification_settings_response.dart
// date: Sep/06/2022
// brief: Notification Settings Json.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:convert';

class NotificationSettingsResponse {
  String? version;
  String? environment;
  List<NotificationSettings>? notificationSettings;

  NotificationSettingsResponse(
      {this.version, this.environment, this.notificationSettings});

  factory NotificationSettingsResponse.fromRawJson(String str) => NotificationSettingsResponse.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  NotificationSettingsResponse.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    environment = json['environment'];
    if (json['notificationSettings'] != null) {
      notificationSettings = <NotificationSettings>[];
      json['notificationSettings'].forEach((v) {
        notificationSettings!.add(NotificationSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['version'] = this.version;
    data['environment'] = this.environment;
    if (this.notificationSettings != null) {
      data['notificationSettings'] =
          this.notificationSettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationSettings {
  String? applianceType;
  int? applianceTypeDec;
  int? apiVersion;

  NotificationSettings(
      {this.applianceType, this.applianceTypeDec, this.apiVersion});

  factory NotificationSettings.fromRawJson(String str) => NotificationSettings.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  NotificationSettings.fromJson(Map<String, dynamic> json) {
    applianceType = json['applianceType'];
    applianceTypeDec = json['applianceTypeDec'];
    apiVersion = json['ApiVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['applianceType'] = this.applianceType;
    data['applianceTypeDec'] = this.applianceTypeDec;
    data['ApiVersion'] = this.apiVersion;
    return data;
  }
}