import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_information_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/network_data_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/resources/storage/ble_commissioning_storage.dart';
import 'package:smarthq_flutter_module/resources/storage/gateway_storage.dart';
import 'package:smarthq_flutter_module/services/wifi_locker_model.dart';
import 'package:smarthq_flutter_module/services/wifi_locker_service.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class BleCommissioningCubit extends Cubit<BleCommissioningState> {

  late BleCommissioningRepository _commissioningRepository;
  late ApiServiceRepository _apiServiceRepository;
  late WifiLockerService _wifiLockerService;
  late LocalDataManager _localDataManager;
  late BleCommissioningStorage _storage;

  late int _seedValue;

  BleCommissioningCubit(
      this._commissioningRepository,
      this._apiServiceRepository,
      this._wifiLockerService,
      this._localDataManager):
        super(BleCommissioningState(seedValue: -1, stateType: BleCommissioningStateType.INITIAL)) {
    geaLog.debug("BleCommissioningCubit is called");

    _commissioningRepository.listenChannel(this);
    _storage = _localDataManager.getStorage(StorageType.bleCommissioning) as BleCommissioningStorage;
    _initBleCommissioningStorage();

    _seedValue = 0;
  }

  void _initBleCommissioningStorage() {
    _storage.setStartByBleCommissioning = false;
    _storage.setIsScanning = false;
    _storage.setIsRepairing = false;
    _storage.setIsRetryPassword = false;
    _storage.setApplianceType = ApplianceType.UNDEFINED;
  }

  ////// ACTION
  void initState() {
    emit(BleCommissioningState(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.INITIAL
    ));
  }

  // TODO: Deprecated Function
  void actionBleStartIbeaconScanning() {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SCAN_RESULT,
        menuState: AddApplianceMenuState.SHOW_SCANNING_MENU,
        menuDataApplianceNames: null,
        menuDataApplianceTypes: null
    ));

    _storage.setIsScanning = true;
    _commissioningRepository.actionBleStartIBeaconScanning();
  }

  // TODO: Deprecated Function
  void actionBleStartPairingAction1(ApplianceType applianceType) {
    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.SHOW_PAIRING_LOADING,
    ));

    _commissioningRepository.actionBleStartPairingAction1(ApplianceErd.getApplianceErd(applianceType));
  }

  void actionBleStartConnection(int menuIndex) {

    actionBleStopScanning();

    actionSetFromSavedConnectionFlag(false);
    actionRequestSavedWifiNetworks();

    var detectedScanningList = _storage.detectedScanningList;
    var detectedAppliance = detectedScanningList[menuIndex];
    var applianceTypeErd = detectedAppliance['applianceType'];
    if (detectedAppliance['scanType'] == 'ibeacon') {
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.MOVE_TO_CATEGORY_PAGE,
          applianceType: ApplianceErd.getApplianceType(applianceTypeErd)
      ));
    }
    else {
      emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SHOW_PAIRING_LOADING,
      ));

      _storage.setApplianceType = ApplianceErd.getApplianceType(applianceTypeErd);

      var advertisementIndex = detectedAppliance['advertisementIndex'];
      _commissioningRepository.actionBleStartPairingAction3(applianceTypeErd, advertisementIndex);
    }
  }

  void actionBleMoveToWelcomePage(ApplianceType applianceType, String? subType) {
    _commissioningRepository.actionBleMoveToWelcomePage(ApplianceErd.getApplianceErd(applianceType), subType);
  }

  void actionBleGoToSetting() {
    _commissioningRepository.actionBleGoToSetting();
  }

  void actionBleStartPairingAction2(ApplianceType applianceType, VoidCallback moveToNextPage, {bool startContinuousScan = false}) {
    geaLog.debug("actionBleStartPairingAction2");
    actionSetFromSavedConnectionFlag(false);
    actionRequestSavedWifiNetworks();

    if (_storage.savedBleState == 'on') {
      emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SHOW_PAIRING_LOADING,
      ));
      if (startContinuousScan) {
        geaLog.debug("BLE_BG => Initial ContinuousScan status updated");
        _storage.setMultiErdScan = false;
        _storage.setApplianceType = applianceType;
        _storage.setIsScanning = true;
      }
      _commissioningRepository.actionBleStartPairingAction2(ApplianceErd.getApplianceErd(applianceType));
      if (startContinuousScan) {
        _setContinuousScan(continuousScan: true);
      }
    }
    else {
      moveToNextPage();
    }
  }

  void actionBleStartPairingAction2List(List<ApplianceType> applianceTypes, VoidCallback moveToNextPage, {bool startContinuousScan = false}) {

    geaLog.debug("actionBleStartPairingAction2List");
    if (_storage.savedBleState == 'on') {
      emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SHOW_PAIRING_LOADING,
      ));
      if (startContinuousScan) {
        geaLog.debug("BLE_BG => Initial ContinuousScan status updated for List");
        _storage.setMultiErdScan = true;
        _storage.setApplianceTypes = applianceTypes;
        _storage.setIsScanning = true;
      }
      final erdList = applianceTypes.map((type) => ApplianceErd.getApplianceErd(type));
      _commissioningRepository.actionBleStartPairingAction2List(erdList.toList());
      if (startContinuousScan) {
        _setContinuousScan(continuousScan: true);
      }
    }
    else {
      moveToNextPage();
    }
  }

  void actionBleRequestNetworkList() {
    _commissioningRepository.actionBleRequestNetworkList();

    _storage.setIsRepairing = false;
    _storage.setIsRetryPassword = false;
  }

  void initBleCommissioningNetworkListState() {
    emit(BleCommissioningState(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.NETWORK_LIST_INITIAL,
    ));
  }

  void actionBleSaveSelectedNetworkInformation(String password) {
    geaLog.debug("actionBleSaveSelectedNetworkInformation ${_storage.ssid}, $password, ${_storage.securityType}");
    _commissioningRepository.actionBleSaveSelectedNetworkInformation(_storage.ssid, _storage.securityType, password);

    _wifiLockerService.ssid = _storage.ssid;
    _wifiLockerService.securityType = _storage.securityType;
    _wifiLockerService.password = password;
  }

  void actionBleSaveSelectedNetworkIndex() {
    geaLog.debug("actionBleSaveSelectedNetworkIndex");
    _commissioningRepository.actionBleSaveSelectedNetworkIndex(_storage.selectedIndex);
  }

  void keepACMPassword(String password) {
    _storage.setAcmPassword = password;
  }

  void keepSsidNSecurityType(String? ssid, String? securityType) {
    _storage.setSsid = ssid;
    _storage.setSecurityType = securityType;
  }

  void keepSsidNSecurityTypeNEncryptType(String? ssid, String? securityType, String? encryptType) {
    _storage.setSsid = ssid;
    _storage.setSecurityType = _wifiLockerService.getBleNetworkSecurityTypeForWifiLocker(securityType, encryptType);
  }

  void keepSelectedIndex(int index) {
    geaLog.debug("keepSelectedIndex");
    _storage.setSelectedIndex = index;
  }

  void _setContinuousScan({required bool continuousScan}) {
    _storage.setContinuousScan = continuousScan;
  }

  /// To cancel ongoing BLE scan and to ensure no further auto BLE scan happens
  void stopAndCancelContinuousBleScan() {
    geaLog.debug("BLE_BG => stopAndCancelContinuousBleScan");
    actionBleStopScanning();
    _storage.setIsScanning = false;
    _storage.setMultiErdScan = false;
  }

  /// Used to restart scanning in case user comes back to a page where continuous BLE scan should happen
  /// after scanning is stopped forcefully
  void restartContinuousScanForAppliance({bool restartContinuousScan = true}) {
    geaLog.debug("BLE_BG => restartContinuousScanForAppliance");
    if (restartContinuousScan && !_storage.isContinuousScan) {
      geaLog.debug("BLE_BG => setting ContinuousScan to true");
      _setContinuousScan(continuousScan: true);
      _commissioningRepository.actionBleStartPairingAction2(ApplianceErd.getApplianceErd(_storage.applianceType));
    }
  }

  void restartContinuousScanForAppliances() {
    geaLog.debug('BLE_BG => restartContinuousScanForAppliances');
    if (!_storage.isContinuousScan) {
      geaLog.debug("BLE_BG => setting ContinuousScan to true for list of appliances");
      _setContinuousScan(continuousScan: true);
      final erdList = _storage.applianceTypes.map((type) => ApplianceErd.getApplianceErd(type));
      _commissioningRepository.actionBleStartPairingAction2List(erdList.toList());
    }
  }

  bool isIndexFromSavedNetworksExisted(String? ssid) {
    geaLog.debug("isIndexFromSavedNetworksExisted");
    final networks = _wifiLockerService.getNetworksFromBleModule();
    if (ssid == null || networks == null) {
      return false;
    }

    for (var index = 0; index < networks.length; index++) {
      if (_wifiLockerService.areBothStringsSame(ssid, networks[index]['ssid']) == true) {
        keepSelectedIndex(index);
        return true;
      }
    }

    return false;
  }

  NetworkDataItem? getValidSavedNetwork(List<NetworkDataItem>? networks) {
    NetworkDataItem? savedNetwork;

    networks?.forEach((element) {
      if (isIndexFromSavedNetworksExisted(element.ssid) == true) {
        savedNetwork = element;
        return;
      }
    });

    return savedNetwork;
  }

  void actionBleStartCommissioning() {
    if (_storage.applianceType == ApplianceType.GATEWAY) {
      _commissioningRepository.actionBleStartCommissioningOnlyModule();
    }
    else {
      _commissioningRepository.actionBleStartCommissioning();
    }
  }

  void actionBleStartAllScanning() {

    var rescanCount = _storage.rescanCount;
    _storage.setRescanCount = rescanCount + 1;

    _storage.detectedScanningList.clear();

    _commissioningRepository.actionBleStartAllScanning();

    _storage.setIsScanning = true;

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SCAN_RESULT,
        menuState: AddApplianceMenuState.SHOW_SCANNING_MENU,
        menuDataApplianceNames: null,
        menuDataApplianceTypes: null
    ));
  }

  void actionBleStopScanning() {

    geaLog.debug("BLE_BG => actionBleStopScanning");
    if (_storage.isScanning) {
      geaLog.debug("BLE_BG => Stopping continuousScan");
      _setContinuousScan(continuousScan: false);
      _commissioningRepository.actionBleStopScanning();
    }
  }

  void actionClearScanningList() {
    _storage.setRescanCount = 0;
    _storage.detectedScanningList.clear();

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SCAN_RESULT,
        menuState: AddApplianceMenuState.SHOW_RESCAN_MENU,
        menuDataApplianceNames: null,
        menuDataApplianceTypes: null
    ));
  }

  void actionRetryPairing() {
    _commissioningRepository.actionBleRetryPairing();
  }

  void actionCheckShouldScan() {
    if (_storage.isRepairing || _storage.isRetryPassword) {
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_NETWORK_LIST
      ));
    }
  }

  void actionBleSetRetryPasswordFlag() {
    _storage.setIsRetryPassword = true;
  }

  Future<String> actionDirectBleDeviceState() async {
    var bleState = await _commissioningRepository.actionDirectBleDeviceState();
    _storage.setBleState = bleState;

    return bleState;
  }

  void checkGatewayStartScreen() async {

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SHOW_CLOUD_LOADING
    ));

    List<Devices>? gatewayList = await _apiServiceRepository.fetchGatewayList();
    final gatewayInfoList = gatewayList.map(
            (gateway) => GatewayInfo(
            gateway.nickname ?? "",
            gateway.deviceId ?? "",
            gateway.gatewayId ?? "")).toList();
    final gatewayCount = gatewayInfoList.length;

    BleCommissioningStateType type = BleCommissioningStateType.MOVE_TO_GATEWAY_STARTED_PAGE;
    if (gatewayCount == 1) {
      type = BleCommissioningStateType.MOVE_TO_SELECT_GATEWAY_PAGE;
    }
    else if (gatewayCount > 1) {
      type = BleCommissioningStateType.MOVE_TO_SELECT_GATEWAY_LIST_PAGE;
    }

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.HIDE_CLOUD_LOADING
    ));

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: type,
        gatewayInfoList: gatewayInfoList
    ));
  }

  ////// LISTEN
  void actionDirectBleGetSearchedBeaconList() {
    _commissioningRepository.actionDirectBleGetSearchedBeaconList()
        .then((applianceErds) {
      _updateNearByMenuWith(applianceErds);
    });
  }

  void _updateNearByMenuWith(List<String>? applianceErds) async {
    geaLog.debug("_updateNearByMenuWith");

    // call to update the ble state
    await actionDirectBleDeviceState();

    _storage.setRescanCount = 0;
    _storage.detectedScanningList.clear();

    AddApplianceMenuState menuState;
    menuState = AddApplianceMenuState.SHOW_SCANNING_MENU;

    if (_storage.savedBleState == 'off') {
      menuState = AddApplianceMenuState.GO_TO_SETTING_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
      return;
    }

    // Start by Add Appliance Button on Dashboard
    if (applianceErds == null) {
      menuState = AddApplianceMenuState.SHOW_SCANNING_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));

      _storage.setIsScanning = true;
      _commissioningRepository.actionBleStartAllScanning();
    }
    else if (applianceErds.length == 0) {
      menuState = AddApplianceMenuState.SHOW_RESCAN_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
    }
    else if (applianceErds.length >= 1) {

      var detectedScanningList = _storage.detectedScanningList;
      List<String> menuDataApplianceNames = [];
      List<ApplianceType> menuDataApplianceTypes = [];
      applianceErds.asMap().forEach((index, applianceErd) {
        var applianceType = ApplianceErd.getApplianceType(applianceErd);
        if (applianceType != ApplianceType.UNDEFINED) {
          menuDataApplianceNames.add(ApplianceErd.getApplianceName(applianceErd, ContextUtil.instance.context!));
          menuDataApplianceTypes.add(applianceType);

          detectedScanningList.add({'scanType': 'ibeacon', 'advertisementIndex': index, 'applianceType': applianceErd});
        }
      });
      _storage.setDetectedScanningList = detectedScanningList;

      if (menuDataApplianceTypes.isEmpty) {
        menuState = AddApplianceMenuState.SHOW_RESCAN_MENU;
        emit(state.copyWith(
            seedValue: _seedValue++,
            stateType: BleCommissioningStateType.SCAN_RESULT,
            menuState: menuState,
            menuDataApplianceNames: null,
            menuDataApplianceTypes: null
        ));
      }
      else {

        // Move to each appliance category page
        if (menuDataApplianceTypes.length == 1) {
          emit(state.copyWith(
              seedValue: _seedValue++,
              stateType: BleCommissioningStateType.MOVE_TO_CATEGORY_PAGE,
              applianceType: menuDataApplianceTypes.first
          ));

          _storage.setStartByBleCommissioning = false;
        }
        else {
          emit(state.copyWith(
              seedValue: _seedValue++,
              stateType: BleCommissioningStateType.SHOW_SCAN_INDICATOR,
              showNearbyIndicator: true
          ));

          _storage.setIsScanning = true;
          _commissioningRepository.actionBleStartAdvertisementScanning();

          // TODO: For Test
          // Future.delayed(Duration(seconds: 2), () async {
          //   this.responseDetectedScanning('advertisement', 0, '03');
          // });
          // Future.delayed(Duration(seconds: 3), () async {
          //   this.responseDetectedScanning('advertisement', 1, '04');
          // });
          // Future.delayed(Duration(seconds: 4), () async {
          //   this.responseDetectedScanning('advertisement', 2, '08');
          // });
          // Future.delayed(Duration(seconds: 5), () async {
          //   this.responseFinishedScanning();
          // });
        }

        menuState = AddApplianceMenuState.SHOW_LIST_MENU;
        emit(state.copyWith(
            seedValue: _seedValue++,
            stateType: BleCommissioningStateType.SCAN_RESULT,
            menuState: menuState,
            menuDataApplianceNames: menuDataApplianceNames,
            menuDataApplianceTypes: menuDataApplianceTypes
        ));
      }
    }
  }

  ////// LISTEN
  // TODO: Deprecated Function
  void responseBleIbeaconScanningResult(List<String>? applianceErds) {
    AddApplianceMenuState menuState;
    menuState = AddApplianceMenuState.SHOW_SCANNING_MENU;

    if (_storage.savedBleState == 'off') {
      menuState = AddApplianceMenuState.GO_TO_SETTING_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
      return;
    }

    if (applianceErds != null) {
      if (applianceErds.length == 0) {
        menuState = AddApplianceMenuState.SHOW_RESCAN_MENU;
        emit(state.copyWith(
            seedValue: _seedValue++,
            stateType: BleCommissioningStateType.SCAN_RESULT,
            menuState: menuState,
            menuDataApplianceNames: null,
            menuDataApplianceTypes: null
        ));
      }
      else if (applianceErds.length > 0) {
        menuState = AddApplianceMenuState.SHOW_LIST_MENU;

        List<String> menuDataApplianceNames = [];
        List<ApplianceType> menuDataApplianceTypes = [];
        applianceErds.forEach((applianceErd) {
          menuDataApplianceNames.add(ApplianceErd.getApplianceName(applianceErd, ContextUtil.instance.context!));
          menuDataApplianceTypes.add(ApplianceErd.getApplianceType(applianceErd));
        });

        emit(state.copyWith(
            seedValue: _seedValue++,
            stateType: BleCommissioningStateType.SCAN_RESULT,
            menuState: menuState,
            menuDataApplianceNames: menuDataApplianceNames,
            menuDataApplianceTypes: menuDataApplianceTypes
        ));
      }
    }
  }

  // TODO: Deprecated Function
  void responseBleStartPairingAction1Result(String? applianceErd, bool? isSuccess) {

    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.HIDE_PAIRING_LOADING,
    ));

    if (applianceErd != null && isSuccess != null) {
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.START_PAIRING_ACTION1_RESULT,
          applianceType: ApplianceErd.getApplianceType(applianceErd),
          isSuccess: isSuccess
      ));

      _storage.setStartByBleCommissioning = isSuccess;
    }
  }

  void responseBleStartPairingAction2Result(String? applianceErd, bool? isSuccess) {

    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.HIDE_PAIRING_LOADING,
    ));

    if (applianceErd != null && isSuccess != null) {
      final applianceType = ApplianceErd.getApplianceType(applianceErd);
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.START_PAIRING_ACTION2_RESULT,
          applianceType: applianceType,
          isSuccess: isSuccess
      ));

      _storage.setApplianceType = applianceType;
      _storage.setStartByBleCommissioning = isSuccess;

      if (_storage.isContinuousScan) {

        if (!isSuccess) {
          geaLog.debug("BLE_BG => Not connected + ContinuousScan in-progress");
          _storage.setIsScanning = true;
          if(_storage.isMultiErdScan){
            geaLog.debug("BLE_BG => attempt to re-pair to multiple erd list");
            final erdList = _storage.applianceTypes.map((type) => ApplianceErd.getApplianceErd(type));
            _commissioningRepository.actionBleStartPairingAction2List(erdList.toList());
          }else{
            geaLog.debug("BLE_BG => attempt to re-pair to single erd list");
            _commissioningRepository.actionBleStartPairingAction2(ApplianceErd.getApplianceErd(_storage.applianceType));
          }

        } else {
          geaLog.debug("BLE_BG => Successfully connected with Appliance");
          _setContinuousScan(continuousScan: false);
        }
      }
    }
  }

  void responseBleStartPairingAction3Result(String? applianceErd, bool? isSuccess) {

    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.HIDE_PAIRING_LOADING,
    ));

    if (applianceErd != null && isSuccess != null) {
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.START_PAIRING_ACTION3_RESULT,
          applianceType: ApplianceErd.getApplianceType(applianceErd),
          isSuccess: isSuccess
      ));

      _storage.setStartByBleCommissioning = isSuccess;
    }
  }

  void responseProgressStep(int? step, bool? isSuccess) async {

    if (step == null || isSuccess == null)
      return;

    if (_storage.applianceType == ApplianceType.GATEWAY) {
      if (!isSuccess) {
        emit(state.copyWith(
            seedValue: _seedValue++,
            stateType: BleCommissioningStateType.PROGRESS,
            progressStep: {'step': step, 'isSuccess': isSuccess}
        ));
      } else if (step == 1) {
        emit(state.copyWith(
            seedValue: _seedValue++,
            stateType: BleCommissioningStateType.PROGRESS,
            progressStep: {'step': step, 'isSuccess': isSuccess}
        ));

        await startToCheckCommissioningWithCloud();
      }
    }
    else {
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.PROGRESS,
          progressStep: {'step': step, 'isSuccess': isSuccess}
      ));
    }
  }

  Future<void> startToCheckCommissioningWithCloud() async {
    final updId = await _commissioningRepository.actionDirectBleGetUpdId();
    // final updId = "001380d65307";
    geaLog.debug('updId: $updId');

    final deviceId = await _checkStep2(updId);
    if (deviceId != null) {
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.PROGRESS,
          progressStep: {'step': 2, 'isSuccess': true}
      ));

      final isSuccess = await _checkStep3(deviceId)
          .onError((error, stackTrace) {
        return false;
      });
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.PROGRESS,
          progressStep: {'step': 3, 'isSuccess': isSuccess}
      ));
    }
    else {
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.PROGRESS,
          progressStep: {'step': 2, 'isSuccess': false}
      ));
    }
  }

  Timer? _findTimer;
  var _findTimerCount = 0;
  Future<String?> _checkStep2(String updId) async {

    final completer = Completer<String?>();

    if (_findTimer == null) {
      _findTimerCount = 0;
      _findTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
        geaLog.debug("try to find the device by updId($updId) - $_findTimerCount");
        final deviceId = await _apiServiceRepository.getDeviceIdByUpdId(updId);
        geaLog.debug("deviceId: $deviceId");
        if (deviceId != null) {
          _findTimer?.cancel();
          _findTimer = null;
          completer.complete(deviceId);
          return;
        }
        else {
          _findTimerCount++;
          if (_findTimerCount > 17) {
            _findTimer?.cancel();
            _findTimer = null;
            completer.complete(null);
            return;
          }
        }
      });
    }

    return completer.future;
  }

  Timer? _finishTimer;
  Future<bool> _checkStep3(String deviceId) async {

    final gatewayStorage = _localDataManager.getStorage(StorageType.gateway) as GatewayStorage;
    gatewayStorage.setDeviceId = deviceId;

    final completer = Completer<bool>();

    if (_finishTimer == null) {
      _finishTimer = Timer.periodic(Duration(minutes: 5), (timer) async {
        _finishTimer?.cancel();
        _finishTimer = null;
        completer.complete(false);
        return;
      });
    }

    DeviceInformationResponse response = await _apiServiceRepository.getDeviceInfo(deviceId);

    _finishTimer?.cancel();
    _finishTimer = null;

    final services = response.services;
    if (services != null && services.isNotEmpty) {
      final result = services.where(
              (service) => (service.domainType == "cloud.smarthq.domain.add"
              && service.serviceType == "cloud.smarthq.service.toggle"
              && service.serviceDeviceType == "cloud.smarthq.device.bluetooth")).toList();

      if (result.isNotEmpty) {
        gatewayStorage.setGatewayId = response.gatewayId;
      }
      completer.complete(result.isNotEmpty);
    }
    else {
      completer.complete(false);
    }

    return completer.future;
  }

  /// If the index value is -1, both deviceId and gatewayId are got from LocalDataManager
  /// The other case, deviceId and gatewayId are got from state.gatewayInfoList.
  /// The state.gatewayInfoList was set by calling the function named "checkGatewayStartScreen"
  void startPairingSensor({int index = -1, bool shouldFetchSensorList = true}) async {
    geaLog.debug("startPairingSensor");

    final gatewayStorage = _localDataManager.getStorage(StorageType.gateway) as GatewayStorage;

    String? deviceId;
    String? gatewayId;
    if (index == -1) {
      deviceId = gatewayStorage.deviceId;
      gatewayId = gatewayStorage.gatewayId;
    }
    else {
      deviceId = state.gatewayInfoList?[index].deviceId;
      gatewayId = state.gatewayInfoList?[index].gatewayId;
    }

    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.SHOW_PAIRING_LOADING,
    ));

    bool isSuccess = false;
    if (deviceId != null) {
      isSuccess = await _apiServiceRepository.postPairSensor(deviceId);
    }
    geaLog.debug("startPairingSensor: isSuccess:$isSuccess");

    if (gatewayId != null && shouldFetchSensorList) {
      gatewayStorage.setSensorList = await _apiServiceRepository.fetchLeakSensorByGatewayId(gatewayId);
    }
    geaLog.debug("startPairingSensor: gatewayId:$gatewayId");

    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.HIDE_PAIRING_LOADING,
    ));

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.START_PAIRING_SENSOR_RESULT,
        isSuccessToStartParingSensor: isSuccess
    ));
  }

  void actionDirectBleGetInfoToPairSensor() async {
    final response = await _commissioningRepository.actionDirectBleGetInfoToPairSensor();

    final deviceId = response['deviceId'];
    final gatewayId = response['gatewayId'];

    final gatewayStorage = _localDataManager.getStorage(StorageType.gateway) as GatewayStorage;
    gatewayStorage.setDeviceId = deviceId;
    gatewayStorage.setGatewayId = gatewayId;

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.MOVE_TO_PAIR_SENSOR_PAGE
    ));
  }

  void startToCheckParingSensorWithCloud() async {
    bool? isSuccess;

    final gatewayStorage = _localDataManager.getStorage(StorageType.gateway) as GatewayStorage;
    final gatewayId = gatewayStorage.gatewayId;
    if (gatewayId != null) {
      isSuccess = await _checkParingSensorWithCloud(gatewayId);
    }

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.PAIRING_SENSOR_COMPLETE_RESULT,
        isSuccessToCompleteParingSensor: (isSuccess != null && isSuccess) ? true : false
    ));
  }

  Timer? _findLeakSensorTimer;
  var _findLeakSensorTimerCount = 0;
  Future<bool?> _checkParingSensorWithCloud(String gatewayId) async {
    final completer = Completer<bool>();
    final gatewayStorage = _localDataManager.getStorage(StorageType.gateway) as GatewayStorage;
    if (_findLeakSensorTimer == null) {
      _findLeakSensorTimerCount = 0;
      _findLeakSensorTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
        geaLog.debug("try to find the leak sensor by gateway($gatewayId) - $_findLeakSensorTimerCount");

        List<Devices>? sensorList = await _apiServiceRepository.fetchLeakSensorByGatewayId(gatewayId);

        String? sensorDeviceId;
        sensorList.forEach((Devices devices) {
          final preSensorList = gatewayStorage.sensorList;
          final index = preSensorList!.indexWhere(
                  (Devices element) => (element.deviceId == devices.deviceId));
          if (index == -1) {
            sensorDeviceId = devices.deviceId;
            return;
          }
          else {
            if (preSensorList[index].createdDateTime != devices.createdDateTime) {
              sensorDeviceId = devices.deviceId;
              return;
            }
          }
        });

        gatewayStorage.setSensorDeviceId = sensorDeviceId;

        if (sensorDeviceId != null) {
          _findLeakSensorTimer?.cancel();
          _findLeakSensorTimer = null;
          completer.complete(true);
          return;
        }
        else {
          _findLeakSensorTimerCount++;
          if (_findLeakSensorTimerCount == 24) {
            _findLeakSensorTimer?.cancel();
            _findLeakSensorTimer = null;
            completer.complete(false);
            return;
          }
        }
      });
    }

    return completer.future;
  }

  void postNickName(String tagValue) async {
    final gatewayStorage = _localDataManager.getStorage(StorageType.gateway) as GatewayStorage;
    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.SHOW_CLOUD_LOADING,
    ));

    bool? isSuccess;
    final sensorDeviceId = gatewayStorage.sensorDeviceId;
    if (sensorDeviceId != null) {
      isSuccess = await _apiServiceRepository.postNickName(sensorDeviceId, tagValue);
    }

    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.HIDE_CLOUD_LOADING,
    ));

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.POST_NICKNAME_RESULT,
        isSuccessToPostNickName: (isSuccess != null && isSuccess) ? true : false
    ));
  }

  void responseBleNetworkJoinStatusFail() {
    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.NETWORK_JOIN_STATUS_FAIL,
    ));
  }

  void responseBleNetworkStatusDisconnected() {
    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.NETWORK_STATUS_DISCONNECT,
    ));
  }

  void responseBleDeviceState(String? bleState) {
    AddApplianceMenuState menuState;
    if (bleState == 'on' && _storage.savedBleState == 'off') {
      menuState = AddApplianceMenuState.SHOW_RESCAN_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
    }
    else if (bleState == 'off') {
      menuState = AddApplianceMenuState.GO_TO_SETTING_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
    }

    _storage.setBleState = bleState;
  }

  void responseNetworkList(List<Map<String, String>>? networkList) {
    geaLog.debug("network list: $networkList");
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.NETWORK_LIST,
        networkListFromWifiModule: networkList
    ));
  }

  void responseDetectedScanning(String? scanType, int? advertisementIndex, String? applianceType) {

    var isAvailableApplianceType = true;
    if (scanType == 'ibeacon') {
      var applianceTypeValue = ApplianceType.UNDEFINED;

      if (applianceType != null) {
        applianceTypeValue = ApplianceErd.getApplianceType(applianceType);
      }

      if (applianceTypeValue == ApplianceType.UNDEFINED) {
        isAvailableApplianceType = false;
      }
    }

    // update the scanning list
    var detectedScanningList = _storage.detectedScanningList;
    if (isAvailableApplianceType) {

      var findIndex = -1;
      detectedScanningList.asMap().forEach((index, element) {
        var id = element['advertisementIndex'];
        if (id == advertisementIndex) {
          findIndex = index;
          return;
        }
      });

      var alreadyHasItem = (findIndex != -1);
      if (alreadyHasItem) {
        detectedScanningList[findIndex] = {'scanType': scanType, 'advertisementIndex': advertisementIndex, 'applianceType': applianceType};
      }
      else {
        detectedScanningList.add({'scanType': scanType, 'advertisementIndex': advertisementIndex, 'applianceType': applianceType});
      }
      _storage.setDetectedScanningList = detectedScanningList;
    }

    AddApplianceMenuState menuState;
    if (_storage.savedBleState == 'off') {
      menuState = AddApplianceMenuState.GO_TO_SETTING_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
      return;
    }

    if (detectedScanningList.isEmpty) {
      menuState = AddApplianceMenuState.SHOW_SCANNING_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
    }
    else {
      // make a model to show the NEARBY menu
      List<String> menuDataApplianceNames = [];
      List<ApplianceType> menuDataApplianceTypes = [];
      detectedScanningList.forEach((element) {
        var applianceErd = element['applianceType'];
        var applianceType = ApplianceErd.getApplianceType(applianceErd);
        var applianceName = ApplianceErd.getApplianceName(applianceErd, ContextUtil.instance.context!);

        menuDataApplianceNames.add(applianceName);
        menuDataApplianceTypes.add(applianceType);
      });

      menuState = AddApplianceMenuState.SHOW_LIST_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: menuDataApplianceNames,
          menuDataApplianceTypes: menuDataApplianceTypes
      ));

      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SHOW_SCAN_INDICATOR,
          showNearbyIndicator: true
      ));
    }
  }

  void responseFinishedScanning() {

    _storage.setIsRepairing = false;
    _storage.setIsRetryPassword = false;
    _storage.setIsScanning = false;

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SHOW_SCAN_INDICATOR,
        showNearbyIndicator: false
    ));

    AddApplianceMenuState menuState;
    if (_storage.savedBleState == 'off') {
      menuState = AddApplianceMenuState.GO_TO_SETTING_MENU;
      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
      return;
    }

    var detectedScanningList = _storage.detectedScanningList;
    if (detectedScanningList.isEmpty) {

      if (_storage.rescanCount >= 2) {
        menuState = AddApplianceMenuState.SHOW_RESCAN_MENU_WITHOUT_BUTTON;
      }
      else {
        menuState = AddApplianceMenuState.SHOW_RESCAN_MENU;
      }

      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.SCAN_RESULT,
          menuState: menuState,
          menuDataApplianceNames: null,
          menuDataApplianceTypes: null
      ));
    }
  }

  void responseBleRetryPairing(bool? isSuccess) {
    if (isSuccess != null) {
      _storage.setIsRepairing = isSuccess;

      emit(state.copyWith(
          seedValue: _seedValue++,
          stateType: BleCommissioningStateType.RETRY_PAIRING_RESULT,
          isSuccess: isSuccess
      ));
    }
  }

  void responseBleMoveToRootCommissioningPage() {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.MOVE_TO_ROOT_COMMISSIONING_PAGE
    ));
  }

  void responseBleFailToConnect() {
    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: BleCommissioningStateType.HIDE_PAIRING_LOADING,
    ));

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.FAIL_TO_CONNECT
    ));

    if (_storage.isContinuousScan) {
      geaLog.debug("BLE_BG => Scanning- BLE failed to connect");
      _storage.setIsScanning = true;
      _commissioningRepository.actionBleStartPairingAction2(ApplianceErd.getApplianceErd(_storage.applianceType));
    }
  }

  Future<void> actionRequestSavedWifiNetworks() async {
    geaLog.debug("actionRequestSavedWifiNetworks");
    await _wifiLockerService.actionRequestSavedWifiNetworks().then((value) {
      if(value == null) {
        geaLog.debug("network list is null, no need to set emit the list");
      } else {
        emit(state.copyWith(
            seedValue: _seedValue++,
            stateType: BleCommissioningStateType.WIFI_LOCKER_NETWORKS,
            savedWifiNetworks: value
        ));
      }
    });
  }

  Future<void> actionFetchSavedWifiNetworks() async {
    geaLog.debug("actionFetchSavedWifiNetworks");
    final savedNetworks = _wifiLockerService.getSavedNetworks();
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.SAVED_WIFI_LOCKER_NETWORKS,
        savedWifiNetworks: savedNetworks
    ));
  }

  void actionStoreNetworkForEditing(NetworkDataItem? network) {
    _wifiLockerService.setSelectedEditNetwork(network);
  }

  NetworkDataItem? actionFetchNetworkForEditing() {
    return _wifiLockerService.getSelectedEditNetwork();
  }

  void actionUpdateNetwork(NetworkDataItem? network, String? password) {
    if (network != null) {
      final id = network.id;
      final networkId = network.networkId;
      if (networkId != null) {
        final ssid = network.ssid;
        final securityType = network.securityType;
        _wifiLockerService.addAction(
            WifiLockerUpdateAction(id: id!,
                networkId: networkId,
                ssid: ssid!,
                password: password!,
                securityType: securityType!)
        );
      } else {
        _wifiLockerService.updateAction(id!, password!);
      }

      _wifiLockerService.updatePasswordToLocal(network, password);
    }
  }

  void actionSetAutoConnectionFlag(bool isTrue) {
    _storage.setIsConnectAutomatically = isTrue;
  }

  void actionSetFromSavedConnectionFlag(bool isTrue) {
    _storage.setIsFromSavedConnection = isTrue;
  }

  void actionRemoveNetwork(NetworkDataItem? network) {
    if (network != null) {
      final id = network.id;
      final networkId = network.networkId;
      if (networkId != null) {
        _wifiLockerService.addAction(
            WifiLockerDeleteAction(
                id: id!,
                networkId: networkId));
      } else {
        _wifiLockerService.removeAction(id!);
      }

      _wifiLockerService.updateRemovalToLocal(network);
    }
  }

  void actionSaveSelectedNetwork(bool shouldStore, String password) {
    geaLog.debug("actionSaveSelectedNetwork ${(shouldStore)?"store":"no"}");
    this.actionSaveNetwork(shouldStore, _wifiLockerService.ssid, password, _wifiLockerService.securityType);
  }

  void actionSaveNetwork(bool shouldStore, String? ssid, String password, String? securityType) {
    geaLog.debug("actionSaveNetwork ${(shouldStore)?"store":"no"}, $ssid, $password, $securityType");
    if (!shouldStore) return;
    if (ssid != null) {
      final idValue = _seedValue++;
      var type = securityType;

      _wifiLockerService.updateAddToLocal(
          NetworkDataItem(
              id: idValue,
              networkId: null,
              ssid: ssid,
              password: password,
              securityType: type ?? CommissioningSecurityType.NONE
          )
      );

      _wifiLockerService.addAction(
          WifiLockerSaveAction(
              id: idValue,
              ssid: ssid,
              password: password,
              securityType: type ?? CommissioningSecurityType.NONE
          )
      );
    }
  }

  Future<void> actionSendUpdatedWifiLockerToCloud() async {
    final isServiceAvailableCountry = await _wifiLockerService.isServiceAvailableCountry();
    if (!isServiceAvailableCountry) {
      // app will send the wifi locker only if the country is available country
      return;
    }

    _wifiLockerService.sendActionToCloud();

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.UPDATES_FINISHED,
        areUpdatesFinished: true
    ));
  }

  void actionSetBleModuleNetworks(List<Map<String, String>>? networks) {
    _wifiLockerService.setNetworksFromBleModule(networks);
  }

  void actionSetSelectedSavedNetworkSsid(String? ssidName) {
    _wifiLockerService.setSavedSelectedNetworkSsidName = ssidName;
  }

  String? actionGetSelectedSavedNetworkSsid() {
    return _wifiLockerService.savedSelectedNetworkSsidName;
  }

  Future<bool> actionGetIsWifiLockerAvailable() async {
    geaLog.debug("actionGetIsWifiLockerAvailable");
    return _wifiLockerService.isServiceAvailableCountry();
  }

  void responseBleMoveToPairSensorPage(String? deviceId, String? gatewayId) {
    final gatewayStorage = _localDataManager.getStorage(StorageType.gateway) as GatewayStorage;
    gatewayStorage.setDeviceId = deviceId;
    gatewayStorage.setGatewayId = gatewayId;

    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: BleCommissioningStateType.MOVE_TO_PAIR_SENSOR_PAGE
    ));
  }
}