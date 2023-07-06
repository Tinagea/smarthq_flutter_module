

import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/resources/storage/base_storage.dart';

abstract class WifiCommissioningStorage extends Storage {
  String? get acmPassword;
  set setAcmPassword(String acmPassword);

  String? get ssid;
  set setSsid(String? ssid);

  String? get securityType;
  set setSecurityType(String? securityType);

  String? get acmSSID;
  set setAcmSSID(String acmSSID);
  
  bool? get isAutoJoin;
  set setAutoJoin(bool isAutoJoin);

  bool? get isUsiType;
  set setUsiType(bool isUsiType);
}

class WifiCommissioningStorageImpl extends WifiCommissioningStorage {
  WifiCommissioningStorageImpl._();
  static final WifiCommissioningStorageImpl _instance = WifiCommissioningStorageImpl._();
  factory WifiCommissioningStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.wifiCommissioning;
  }

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

  String? _acmSSID;
  @override
  String? get acmSSID => _acmSSID;
  @override
  set setAcmSSID(String acmSSID) => _acmSSID = acmSSID;

  bool? _isAutoJoin;
  @override
  bool? get isAutoJoin => _isAutoJoin;
  @override
  set setAutoJoin(bool isAutoJoin) => _isAutoJoin = isAutoJoin;

  bool? _isUsiType;
  @override
  bool? get isUsiType => _isUsiType;
  @override
  set setUsiType(bool isUsiType) => _isUsiType = isUsiType;
}