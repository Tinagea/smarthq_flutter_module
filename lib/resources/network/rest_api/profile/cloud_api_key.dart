part of 'rest_api_profile.dart';

// file: cloud_api_key.dart
// date: Jun/14/2021
// brief: A class for cloud api header key.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

abstract class CloudApiHeaderKey {
  static const contentTypeJson = 'application/json';
  static const contentTypeFormUrlEncoded = 'application/x-www-form-urlencoded';
}

abstract class CloudApiKey {
  // For brandContentsHost
  static const apps = "apps";
  static const appName = "smarthq";
  static const notificationSettings = "notificationSettings.json";
}
