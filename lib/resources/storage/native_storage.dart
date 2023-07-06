import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';
import 'package:smarthq_flutter_module/resources/storage/base_storage.dart';

abstract class NativeStorage extends Storage {
  bool get isStartCommissioningFromDashboard;
  set setIsStartCommissioningFromDashboard(bool isStartFromDashboard);

  bool get isStartPairSensor;
  set setIsStartPairSensor(bool isStartPairSensor);

  String? get countryCode;
  set setCountryCode(String? countryCode);

  RoutingType get routingType;
  set setRoutingType(RoutingType routingType);

  RoutingParameter? get routingParameter;
  set setRoutingParameter(RoutingParameter? routingParameter);

  bool get isModelNumberValidationRequested;
  set setIsModelNumberValidationRequested(bool isModelNumberValidationRequested);

  String? get selectedAppliance;
  set setSelectedAppliance(String? selectedAppliance);

  String? get userId;
  set setUserId(String? userId);
}

class NativeStorageImpl extends NativeStorage {
  NativeStorageImpl._();
  static final NativeStorageImpl _instance = NativeStorageImpl._();
  factory NativeStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.native;
  }

  late bool _isStartCommissioningFromDashboard;
  @override
  bool get isStartCommissioningFromDashboard => _isStartCommissioningFromDashboard;
  @override
  set setIsStartCommissioningFromDashboard(bool isStartFromDashboard) => _isStartCommissioningFromDashboard = isStartFromDashboard;

  late bool _isStartPairSensor;
  @override
  bool get isStartPairSensor => _isStartPairSensor;
  @override
  set setIsStartPairSensor(bool isStartPairSensor) => _isStartPairSensor = isStartPairSensor;

  late String? _countryCode;
  @override
  String? get countryCode => _countryCode;
  @override
  set setCountryCode(String? countryCode) => _countryCode = countryCode;

  RoutingType _routingType = BuildEnvironment.routingType;
  @override
  RoutingType get routingType => _routingType;
  @override
  set setRoutingType(RoutingType routingType) => _routingType = routingType;

  RoutingParameter? _routingParameter;
  @override
  RoutingParameter? get routingParameter => _routingParameter;
  @override
  set setRoutingParameter(RoutingParameter? routingParameter) => _routingParameter = routingParameter;

  late bool _isModelNumberValidationRequested;
  @override
  bool get isModelNumberValidationRequested => _isModelNumberValidationRequested;
  @override
  set setIsModelNumberValidationRequested(bool isModelNumberValidationRequested) => _isModelNumberValidationRequested = isModelNumberValidationRequested;

  late String? _selectedAppliance;
  @override
  String? get selectedAppliance => _selectedAppliance;
  @override
  set setSelectedAppliance(String? selectedAppliance) => _selectedAppliance = selectedAppliance;

  late String? _userId;
  @override
  set setUserId(String? userId) => _userId = userId;
  @override
  String? get userId => _userId;
}