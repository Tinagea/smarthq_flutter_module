

import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/resources/storage/base_storage.dart';

abstract class GatewayStorage extends Storage {
  String? get deviceId;
  set setDeviceId(String? deviceId);

  String? get gatewayId;
  set setGatewayId(String? gatewayId);

  List<Devices>? get sensorList;
  set setSensorList(List<Devices>? sensorList);

  String? get sensorDeviceId;
  set setSensorDeviceId(String? sensorDeviceId);
}

class GatewayStorageImpl extends GatewayStorage {
  GatewayStorageImpl._();
  static final GatewayStorageImpl _instance = GatewayStorageImpl._();
  factory GatewayStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.gateway;
  }

  String? _deviceId;
  @override String? get deviceId => _deviceId;
  @override set setDeviceId(String? deviceId) => _deviceId = deviceId;

  String? _gatewayId;
  @override String? get gatewayId => _gatewayId;
  @override set setGatewayId(String? gatewayId) => _gatewayId = gatewayId;

  List<Devices>? _sensorList;
  @override List<Devices>? get sensorList => _sensorList;
  @override set setSensorList(List<Devices>? sensorList) => _sensorList = sensorList;

  String? _sensorDeviceId;
  @override String? get sensorDeviceId => _sensorDeviceId;
  @override set setSensorDeviceId(String? sensorDeviceId) => _sensorDeviceId = sensorDeviceId;
}