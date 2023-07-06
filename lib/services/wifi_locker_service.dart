import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/network_data_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/services/wifi_locker_model.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

abstract class BaseWifiLockerService {
  Future<NetworkListDataItem?> actionRequestSavedWifiNetworks();
  Future<void> sendActionToCloud();
  Future<bool> isServiceAvailableCountry();
}

class WifiLockerService implements BaseWifiLockerService {
  static const String tag = "WifiLockerService: ";

  late ApiServiceRepository _apiServiceRepository;
  late NativeRepository _nativeRepository;

  WifiLockerService(this._apiServiceRepository, this._nativeRepository);

  final List<WifiLockerAction> actionQueue = [];

  NetworkDataItem? _selectedEditNetwork;

  NetworkListDataItem? _savedNetworks;
  List<Map<String, String>>? _savedModuleNetworks;
  List<Map<String, String>>? _savedBleModuleNetworks;

  String? ssid;
  String? securityType;
  String? password;

  String? _savedSelectedNetworkSsidName;
  String? get savedSelectedNetworkSsidName => _savedSelectedNetworkSsidName;
  set setSavedSelectedNetworkSsidName(String? savedSelectedNetworkSsidName) => _savedSelectedNetworkSsidName = savedSelectedNetworkSsidName;

  @override
  Future<NetworkListDataItem?> actionRequestSavedWifiNetworks() async {
    final isServiceAvailableCountry = await this.isServiceAvailableCountry();
    if(isServiceAvailableCountry) {
      final networks = await _apiServiceRepository.requestSavedWifiNetworks();
      // final replacedNetworks = _replacePasswordForOpenNetwork(networks);
      _savedNetworks = networks;
      return networks;
    } else {
      return null;
    }
  }

  NetworkListDataItem? getSavedNetworks() {
    return _savedNetworks;
  }

  Future<bool> hasSavedNetworkInfo() async {
    final isServiceAvailableCountry = await this.isServiceAvailableCountry();
    if (isServiceAvailableCountry) {
      // when the feature is not enabled it always returns false.
      return false;
    }

    if (_savedNetworks != null && (_savedNetworks?.networks?.length ?? 0) > 0) {
      return true;
    }
    return false;
  }

  Future<NetworkDataItem?> loadFirstNetworkInfo() async {
    final hasSavedNetworkInfo = await this.hasSavedNetworkInfo();
    if (hasSavedNetworkInfo) {
      return _savedNetworks?.networks?.first;
    } else {
      return null;
    }
  }

  void updatePasswordToLocal(NetworkDataItem? network, String? password) {
    for (int index = 0; index < (_savedNetworks?.networks?.length ?? 0); index++) {
      if (_savedNetworks?.networks?[index].networkId == network?.networkId) {
        var networkList = _savedNetworks;
        var networks = networkList?.networks;

        var indexedNetwork = networks?[index];
        indexedNetwork = NetworkDataItem(
            id: indexedNetwork?.id,
            networkId: indexedNetwork?.networkId,
            ssid: indexedNetwork?.ssid,
            password: password,
            securityType: indexedNetwork?.securityType
        );

        networks?[index] = indexedNetwork;
        networkList?.networks = networks;
        _savedNetworks = networkList;
        break;
      }
    }
  }

  void updateRemovalToLocal(NetworkDataItem? network) {
    geaLog.debug("updateRemovalToLocal");

    for (int index = 0; index < (_savedNetworks?.networks?.length ?? 0); index++) {
      geaLog.debug("networkid: ${network?.networkId}, ${_savedNetworks?.networks?[index].networkId}");
      if (_savedNetworks?.networks?[index].networkId == network?.networkId) {
        var networkList = _savedNetworks;
        var networks = networkList?.networks;
        networks?.removeAt(index);
        networkList?.networks = networks;
        _savedNetworks = networkList;

        break;
      }
    }
  }

  void updateAddToLocal(NetworkDataItem network) {
    var networkList = _savedNetworks;
    var networks = networkList?.networks;
    networks?.add(network);
    _savedNetworks = networkList;
  }

  Future<void> sendActionToCloud() async {
    if (actionQueue.length == 0) {
      geaLog.debug("WifiLockerService: sendActionToCloud: no action to send to cloud. return");
      return;
    }

    geaLog.debug("WifiLockerService: sendActionToCloud: send to the cloud");
    actionQueue.forEach((action) async {
      if (action is WifiLockerSaveAction) {
        await _apiServiceRepository.savedWifiNetwork(
            action.ssid,
            action.password,
            //_getPasswordForOpenNetwork(action.password, action.securityType),
            action.securityType);

      } else if (action is WifiLockerUpdateAction) {
        await _apiServiceRepository.updateWifiNetwork(
            action.networkId,
            action.ssid,
            action.password,
            action.securityType);
      } else if (action is WifiLockerDeleteAction) {
        await _apiServiceRepository.removeWifiNetwork(
            action.networkId);
      }
    });

    actionQueue.clear();
  }

  // NetworkListDataItem _replacePasswordForOpenNetwork(NetworkListDataItem networks) {
  //   var networkList = networks.networks;
  //   if (networkList != null) {
  //     final replacedNetworkList = networkList.map((item) {
  //
  //       var password = item.password;
  //       if (item.securityType != null
  //           && CommissioningSecurityType.isOpenNetwork(item.securityType!))
  //         password = '';
  //
  //       return NetworkDataItem(
  //         id: item.id,
  //         networkId: item.networkId,
  //         ssid: item.ssid,
  //         password: password,
  //         securityType: item.securityType,
  //       );
  //     });
  //     networks.networks = replacedNetworkList.toList();
  //   }
  //   return networks;
  // }

  // String _getPasswordForOpenNetwork(String password, String securityType) {
  //   var replacedPassword = password;
  //   if (CommissioningSecurityType.isOpenNetwork(securityType))
  //     replacedPassword = 'none';
  //
  //   return replacedPassword;
  // }

  void addAction(WifiLockerAction action) {
    actionQueue.add(action);
  }

  void removeAction(int id) {
    actionQueue.removeWhere((action) => action.id == id);
  }

  void updateAction(int id, String password) {
    final index = actionQueue.indexWhere((action) => action.id == id);
    final action = actionQueue[index];
    if (action is WifiLockerSaveAction) {
      actionQueue[index] = WifiLockerSaveAction(
          id: action.id,
          ssid: action.ssid,
          password: password,
          securityType: action.securityType);
    }
  }

  void setSelectedEditNetwork(NetworkDataItem? network) {
    _selectedEditNetwork = network;
  }

  NetworkDataItem? getSelectedEditNetwork() {
    return _selectedEditNetwork;
  }

  void setNetworksFromModule(List<Map<String, String>>? networks) {
    _savedModuleNetworks = networks;
  }

  List<Map<String, String>>? getNetworksFromModule() {
    return _savedModuleNetworks;
  }

  void setNetworksFromBleModule(List<Map<String, String>>? networks) {
    _savedBleModuleNetworks = networks;
  }

  List<Map<String, String>>? getNetworksFromBleModule() {
    return _savedBleModuleNetworks;
  }

  String? getBleNetworkSecurityTypeForWifiLocker(String? securityType, String? encryptType) {
    geaLog.debug("getBleNetworkSecurityTypeForWifiLocker: $securityType $encryptType");

    switch (securityType) {
      case BleCommissioningSecurityType.OPEN:
        return CommissioningSecurityType.NONE;
      case BleCommissioningSecurityType.WEP:
        return CommissioningSecurityType.WEP;
      case BleCommissioningSecurityType.WEP_SHARED:
        //TODO WEB_SHARED needs to be declared
        return CommissioningSecurityType.WEP;
      case BleCommissioningSecurityType.WPA:
        if (encryptType == BleCommissioningEncryptType.TKIP) {
          return CommissioningSecurityType.WPA_TKIP_PSK;
        } else if (encryptType == BleCommissioningEncryptType.CCMP) {
          return CommissioningSecurityType.WPA_AES_PSK;
        } else {
          return CommissioningSecurityType.DISABLE;
        }
      case BleCommissioningSecurityType.WPA2:
        if (encryptType == BleCommissioningEncryptType.TKIP) {
          return CommissioningSecurityType.WPA2_TKIP_PSK;
        } else if (encryptType == BleCommissioningEncryptType.CCMP) {
          return CommissioningSecurityType.WPA2_AES_PSK;
        } else if (encryptType == BleCommissioningEncryptType.MIXED) {
          return CommissioningSecurityType.WPA2_MIXED_PSK;
        } else {
          return CommissioningSecurityType.DISABLE;
        }
      case BleCommissioningSecurityType.WPA_WPA2_MIXED:
        return CommissioningSecurityType.WPA_WPA2_MIXED;
      case BleCommissioningSecurityType.WPA3:
        //TODO WPA3-SAE AES needs to be declared
        return CommissioningSecurityType.NONE;
      case BleCommissioningSecurityType.WPA2_WPA3_MIXED:
        // Not defined in module codes either.
        return CommissioningSecurityType.DISABLE;
      case BleCommissioningSecurityType.UNKNOWN:
        return CommissioningSecurityType.DISABLE;
    }

    return null;
  }

  bool areBothStringsSame(String? wifiLockerSsid, String? moduleSsid) {
    geaLog.debug("WifiLockerService:areBothStringsSame: ssid $wifiLockerSsid selected ssid $moduleSsid");
    final regex = RegExp('[^A-Za-z0-9_\%\!\$\-\s ]');
    final replacedWifiLockerSsid = wifiLockerSsid?.replaceAll(regex, '');
    final replacedModuleSsid = moduleSsid?.replaceAll(regex, '');

    if (replacedWifiLockerSsid?.compareTo(replacedModuleSsid ?? '') == 0) {
      return true;
    }

    return false;
  }

  Future<bool> isServiceAvailableCountry() async {
    final countryCode = await _nativeRepository.getCountryCode();
    geaLog.debug("_WifiLockerService: isServiceAvailableCountry $countryCode");

    switch (countryCode) {
      case CountryUtil.us:
      case CountryUtil.ca:
      case CountryUtil.au:
      case CountryUtil.nz:
      case CountryUtil.sg:
        return true;

      default:
        return false;
    }

  }
}