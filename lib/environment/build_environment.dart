// file: build_environment.dart
// date: Nov/25/2021
// brief: Build environment setting.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:smarthq_flutter_module/environment/config/config.dart';
import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/network/config/dev_config.dart';
import 'package:smarthq_flutter_module/resources/network/config/field_config.dart';
import 'package:smarthq_flutter_module/resources/network/config/prod_config.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';

import 'package:smarthq_flutter_module/resources/network/config/base_config.dart';

enum BuildType {
  dev,
  field,
  production
}

enum CommunicationDataType {
  local,
  cloud
}

/// Even if it is set as standAlone,
/// it is actually changed to withNative when the flutter module project build in native.
/// It is judged by the existence of the "f2n_direct_is_running_on_native" function in the native channel.
enum RunEnvType {
  /// the flutter module is running stand-alone without the native project.
  standAlone,
  /// the flutter module is running with the native project.
  withNative
}

enum EnvFeatureType {
  none,
  gateway,
  autofill,
}

class BuildEnvironment {
  ChannelManager? _channelManager;

  var _buildType = BuildType.field;
  var _restApiCommunicationDataType = CommunicationDataType.cloud;
  var _runEnvType = RunEnvType.withNative;
  var _routingType = RoutingType.commissioning;
  late BaseConfig _config;
  bool? _forceLog;

  static BuildType get buildType => _manager?._buildType ?? BuildType.field;
  static CommunicationDataType get restApiCommunicationDataType => _manager?._restApiCommunicationDataType ?? CommunicationDataType.cloud;
  static RunEnvType get runEnvType => _manager?._runEnvType ?? RunEnvType.withNative;
  static RoutingType get routingType => _manager?._routingType ?? RoutingType.commissioning;
  static BaseConfig get config => _manager?._config ?? DevConfig();
  static bool? get forceLog => _manager?._forceLog;
  static bool get showDebugModeBanner => buildType == BuildType.dev;
  static ChannelManager? get channelManager => _manager?._channelManager;

  BaseConfig _getConfig(BuildType buildType) {
    switch (buildType) {
      case BuildType.dev:
        return DevConfig();
      case BuildType.field:
        return FieldConfig();
      case BuildType.production:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }

  static bool hasFeature({required EnvFeatureType featureType}) {
    var hasFeature = false;

    List<EnvFeatureType>? features;
    if (buildType == BuildType.dev) {
      features = EnvDev.features;
    }
    else if (buildType == BuildType.field) {
      features = EnvField.features;
    }
    else if (buildType == BuildType.production) {
      features = EnvProd.features;
    }

    hasFeature = features?.contains(featureType) ?? false;
    return hasFeature;
  }

  static BuildEnvironment? _manager;
  BuildEnvironment._internal(
      this._channelManager,
      this._buildType,
      this._routingType,
      this._restApiCommunicationDataType,
      this._runEnvType,
      this._forceLog) {
    _config = _getConfig(_buildType);
  }

  /// Description for parameters
  ///   BuildType: dev, field, production
  ///   RoutingType: It is not used when the project is running as a module on the native(iOS, Android).
  ///                Please set the routingType to route to when building and running only the Flutter Module itself.
  ///   CommunicationDataType: During testing, it is used to run the app through dummy data without network communication.
  ///   RunEnvType: It is set whether the Flutter Module itself is running on the development tool or running on Native.
  ///               Actually, when running on top of Native, it automatically operates as withNative regardless of the value declared here.
  ///   ForceLog: It is set whether or not to output log
  factory BuildEnvironment.initialize(
      { required ChannelManager channelManager,
        required BuildType buildType,
        RoutingType? routingType,
        CommunicationDataType? restApiDataType,
        RunEnvType? runEnvType,
        bool? forceLog
      }) {
    if(_manager == null) {
      _manager = BuildEnvironment._internal(
          channelManager,
          buildType,
          routingType ?? RoutingType.commissioning,
          restApiDataType ?? CommunicationDataType.cloud,
          runEnvType ?? RunEnvType.withNative,
          forceLog
      );

      _manager?.checkRunEnvType();
    }
    return _manager!;
  }

  void checkRunEnvType() async {
    final isRunningOnNative = await _channelManager!.isRunningOnNative();
    geaLog.debug("isRunningOnNative:$isRunningOnNative");
    if (isRunningOnNative) {
      _manager?._runEnvType = RunEnvType.withNative;
    }
    else {
      _manager?._runEnvType = RunEnvType.standAlone;
    }
  }
}


