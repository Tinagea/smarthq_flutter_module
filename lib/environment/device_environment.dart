// file: device_environment.dart
// date: Nov/25/2021
// brief: Device environment setting.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:io';
import 'build_environment.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

enum PlatformType {
  android, iOS
}

class DeviceEnvironment {
  static final DeviceEnvironment _manager = DeviceEnvironment._();
  factory DeviceEnvironment() {
    return _manager;
  }
  DeviceEnvironment._() {
    Future.delayed(Duration.zero, () async => _initialize() );
  }

  Future<void> _initialize() async {
    if (BuildEnvironment.restApiCommunicationDataType != CommunicationDataType.local) {
      _initPackageInformation();
      _initPlatformInformation();
    } else {
      _appName = "TestApp";
      _appVersion = "0.0.0";
    }
  }

  late String _appVersion;
  String get appVersion => _appVersion;

  late String _appName;
  String get appName => _appName;

  DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  String getUserAgent() {
    var userAgent = "$_appName $_appVersion";
    if (Platform.isIOS) {
      userAgent += " /iOS ${_deviceData["systemVersion"]}/ ${_deviceData["utsname.machine"]}";
    } else {
      userAgent += " /Android ${_deviceData["version.release"]}/ ${_deviceData["model"]}";
    }
    return userAgent;
  }

  PlatformType get platformType => Platform.isIOS
      ? PlatformType.iOS
      : PlatformType.android;

  Future<void> _initPackageInformation() async {
    await PackageInfo.fromPlatform().then((value) {
      geaLog.debug("DeviceEnvironment:_initPackageInformation:Done");
      _appVersion = value.version;
      _appName = value.appName;
    });
  }

  Future<void> _initPlatformInformation() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
      }
      geaLog.debug("DeviceEnvironment:_initPlatformInformation:Done");
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    _deviceData = deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname': data.utsname.sysname,
      'utsname.nodename': data.utsname.nodename,
      'utsname.release': data.utsname.release,
      'utsname.version': data.utsname.version,
      'utsname.machine': data.utsname.machine,
    };
  }
}