

import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/resources/storage/base_storage.dart';

import 'package:smarthq_flutter_module/models/appliance_model.dart';

abstract class BleCommissioningStorage extends Storage {

  String? get savedBleState;
  set setBleState(String? bleState);

  bool? get savedStartByBleCommissioning;
  set setStartByBleCommissioning(bool? startByBleCommissioning);

  String? get acmPassword;
  set setAcmPassword(String acmPassword);

  String? get ssid;
  set setSsid(String? ssid);

  String? get securityType;
  set setSecurityType(String? securityType);

  int? get selectedIndex;
  set setSelectedIndex(int selectedIndex);

  int get rescanCount;
  set setRescanCount(int rescanCount);

  List<Map<String, dynamic>> get detectedScanningList;
  set setDetectedScanningList(List<Map<String, dynamic>> detectedScanningList);

  bool get isScanning;
  set setIsScanning(bool isScanning);

  bool get isRepairing;
  set setIsRepairing(bool isRepairing);

  bool get isRetryPassword;
  set setIsRetryPassword(bool isRetryPassword);

  ApplianceType get applianceType;
  set setApplianceType(ApplianceType applianceType);

  List<ApplianceType> get applianceTypes;
  set setApplianceTypes(List<ApplianceType> applianceType);

  bool get isConnectAutomatically;
  set setIsConnectAutomatically(bool isConnectAutomatically);

  bool get isFromSavedConnection;
  set setIsFromSavedConnection(bool isFromSavedConnection);

  bool get isContinuousScan;
  set setContinuousScan(bool isContinuousScan);

  bool get isMultiErdScan;
  set setMultiErdScan(bool isMultiErdScan);

}

class BleCommissioningStorageImpl extends BleCommissioningStorage {
  BleCommissioningStorageImpl._();
  static final BleCommissioningStorageImpl _instance = BleCommissioningStorageImpl._();
  factory BleCommissioningStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.bleCommissioning;
  }

  String? _bleState;
  @override
  String? get savedBleState => _bleState;
  @override
  set setBleState(String? bleState) => _bleState = bleState;

  bool? _startByBleCommissioning;
  @override
  bool? get savedStartByBleCommissioning => _startByBleCommissioning;
  @override
  set setStartByBleCommissioning(bool? startByBleCommissioning) =>
      _startByBleCommissioning = startByBleCommissioning;

  String? _acmPassword;
  @override
  String? get acmPassword => _acmPassword;
  @override
  set setAcmPassword(String acmPassword) => _acmPassword = acmPassword;

  String? _ssid;
  @override
  String? get ssid => _ssid;
  @override
  set setSsid(String? ssid) => _ssid = ssid;

  String? _securityType;
  @override
  String? get securityType => _securityType;
  @override
  set setSecurityType(String? securityType) => _securityType = securityType;

  int? _selectedIndex;
  @override
  int? get selectedIndex => _selectedIndex;
  @override
  set setSelectedIndex(int selectedIndex) => _selectedIndex = selectedIndex;

  int _rescanCount = 0;
  @override
  int get rescanCount => _rescanCount;
  @override
  set setRescanCount(int rescanCount) => _rescanCount = rescanCount;

  List<Map<String, dynamic>> _detectedScanningList = [];
  @override
  List<Map<String, dynamic>> get detectedScanningList => _detectedScanningList;
  @override
  set setDetectedScanningList(List<Map<String, dynamic>> detectedScanningList) =>
      _detectedScanningList = detectedScanningList;

  bool _isScanning = false;
  @override
  bool get isScanning => _isScanning;
  @override
  set setIsScanning(bool isScanning) => _isScanning = isScanning;

  bool _isRepairing = false;
  @override
  bool get isRepairing => _isRepairing;
  @override
  set setIsRepairing(bool isRepairing) => _isRepairing = isRepairing;

  bool _isRetryPassword = false;
  @override
  bool get isRetryPassword => _isRetryPassword;
  @override
  set setIsRetryPassword(bool isRetryPassword) => _isRetryPassword = isRetryPassword;

  ApplianceType _applianceType = ApplianceType.UNDEFINED;
  @override
  ApplianceType get applianceType => _applianceType;
  @override
  set setApplianceType(ApplianceType applianceType) => _applianceType = applianceType;

  List<ApplianceType> _applianceTypes = [];
  @override
  List<ApplianceType> get applianceTypes => _applianceTypes;
  @override
  set setApplianceTypes(List<ApplianceType> applianceTypes) => _applianceTypes = applianceTypes;

  bool _isConnectAutomatically = false;
  @override
  bool get isConnectAutomatically => _isConnectAutomatically;
  @override
  set setIsConnectAutomatically(bool isConnectAutomatically) => _isConnectAutomatically = isConnectAutomatically;

  bool _isFromSavedConnection = false;
  @override
  bool get isFromSavedConnection => _isFromSavedConnection;
  @override
  set setIsFromSavedConnection(bool isFromSavedConnection) => _isFromSavedConnection = isFromSavedConnection;

  bool _isContinuousScan = false;
  @override
  bool get isContinuousScan => _isContinuousScan;
  @override
  set setContinuousScan(bool isContinuousScan) => _isContinuousScan = isContinuousScan;

  bool _isMultiErdScan = false;
  @override
  bool get isMultiErdScan => _isMultiErdScan;
  @override
  set setMultiErdScan(bool isMultiErdScan) => _isMultiErdScan = isMultiErdScan;

}