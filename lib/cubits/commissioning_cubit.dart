
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/repositories/commissioning_repository.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/network_data_item.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/services/wifi_locker_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

enum AutoJoinStatusType {
  none,
  success,
  fail,
  unSupport
}

class CommissioningCubit extends Cubit<CommissioningState> {

  CommissioningRepository _repository;

  late WifiLockerService _wifiLockerService;
  late LocalDataManager _localDataManager;
  late WifiCommissioningStorage _storage;

  late int _seedValue;

  CommissioningCubit(
      this._repository,
      this._wifiLockerService,
      this._localDataManager):
        super(CommissioningState(seedValue: -1, stateType: CommissioningStateType.INITIAL)) {

    geaLog.debug("CommissioningCubit is called");

    _seedValue = 0;
    _repository.listenChannel(this);
    _storage = _localDataManager.getStorage(StorageType.wifiCommissioning) as WifiCommissioningStorage;
  }

  ////// ACTION
  void initState() {
    emit(CommissioningState(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.INITIAL
    ));
  }

  void initCommissioningNetworkListState() {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.NETWORK_LIST_INITIAL
    ));
  }

  void actionRequestApplicationProvisioningToken() {
    _repository.actionRequestAPT();
  }

  void actionSaveAcmPassword() {
    _repository.actionSaveACMPassword(_storage.acmPassword);
  }

  void actionRequestCommissioningData() {
    _repository.actionRequestCommissioningData();
  }

  void actionRequestGeModuleReachability(bool isOn) {
    _repository.actionRequestGeModuleReachability(isOn);
  }

  void actionRequestNetworkList() {
    _repository.actionRequestNetworkList();
  }

  void actionSaveWifiNetworkInformation(String ssid, String securityType, String password) {
    _repository.actionSaveSelectedNetworkInformation(ssid, securityType, password);
  }

  void actionSaveSelectedNetworkInformation(String password) {
    geaLog.debug("actionSaveSelectedNetworkInformation: passphrase $password");
    _repository.actionSaveSelectedNetworkInformation(_storage.ssid, _storage.securityType, password);
  }

  void actionStartCommissioning() {
    _repository.actionStartCommissioning();
  }

  void keepACMPassword(String password) {
    _storage.setAcmPassword = password;
  }

  void keepAcmSSID(String acmSSID) {
    _storage.setAcmSSID = acmSSID;
  }

  String? actionGetKeptAcmSSID() {
    return _storage.acmSSID;
  }

  String? actionGetKeptAcmPassword() {
    return _storage.acmPassword;
  }

  void keepSsidNSecurityType(String? ssid, String? securityType) {
    _storage.setSsid = ssid;
    _storage.setSecurityType = securityType;
  }

  bool isSavedNetworksExistedInList(String? ssid) {
    geaLog.debug("isSavedNetworksExistedInList");
    final networks = _wifiLockerService.getNetworksFromModule();
    if (ssid == null || networks == null) {
      return false;
    }

    for (var index = 0; index < networks.length; index++) {
      if (_wifiLockerService.areBothStringsSame(ssid, networks[index]['ssid']) == true) {
        keepSsidNSecurityType(networks[index]['ssid'], networks[index]['securityType']);
        return true;
      }
    }

    return false;
  }

  NetworkDataItem? getValidSavedNetwork(List<NetworkDataItem>? networks) {
    NetworkDataItem? savedNetwork;

    networks?.forEach((element) {
      if (isSavedNetworksExistedInList(element.ssid) == true) {
        savedNetwork = element;
        return;
      }
    });

    return savedNetwork;
  }


  String? actionGetKeptSsid() {
    return _storage.ssid;
  }

  String? actionGetKeptSecurityType() {
    return _storage.securityType;
  }

  // move to dashboard
  void actionRequestRelaunch() {
    _repository.actionRequestRelaunch();
  }

  // Go to back screen on Native
  void actionMoveToNativeBackPage() {
    final storage = _localDataManager.getStorage(StorageType.native) as NativeStorage;
    if(storage.isStartCommissioningFromDashboard == false) {
      _repository.actionMoveToNativeBackPage();
    }
  }

  // request Connected Wifi Ssid
  void actionCheckConnectedGeModuleWifi() {
    _repository.actionCheckConnectedGeModuleWifi();
  }

  void actionCancelCommissioning() {
    _repository.actionCancelCommissioning();
  }

  void actionCommissioningSuccessful() {
    _repository.actionCommissioningSuccessful();
  }

  ////// LISTEN
  void responseApplicationProvisioningToken(bool? isSuccess) {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.APT,
        isReceiveApplianceProvisioningToken: isSuccess
    ));
  }

  void responseConnectedGeModuleWifi(bool? isSuccess, int? reason) {
      emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.CONNECTED_MODULE,
        isConnectedGeWifiModule: isSuccess,
        failReason: reason
    ));
  }

  void responseCommissioningData(bool? isSuccess) {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.COMMUNICATION_DATA,
        isSuccessCommunicatingWithWifiModule: isSuccess
    ));
  }

  void responseNetworkList(List<Map<String, String>>? networkList) {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.NETWORK_LIST,
        networkListFromWifiModule: networkList
    ));
  }

  void responseProgressStep(int? step, bool? isSuccess) {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.PROGRESS,
        progressStep: {'step': step, 'isSuccess': isSuccess}
    ));
  }

  void responseNetworkJoinStatusFail() {
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.NETWORK_JOIN_STATUS_FAIL,
    ));
  }

  void responseCheckModuleStatusFromUser() {
    emit(state.copyWith(
      seedValue: _seedValue++,
      stateType: CommissioningStateType.CHECK_MODULE_STATUS_FROM_USER,
    ));
  }

  void setAutoJoinToFalse() {
    _storage.setAutoJoin = false;
  }

  bool? isAutoJoin() {
    return _storage.isAutoJoin;
  }

  void startProcessing(String ssid, String acmPassword) async {
    _storage.setAutoJoin = false;
    AutoJoinStatusType autoJoinStatusType = await _startProcessingInternal(ssid, acmPassword);
    if (autoJoinStatusType == AutoJoinStatusType.success) {
      _storage.setAutoJoin = true;
    }
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.AUTO_JOIN,
        autoJoinStatusType: autoJoinStatusType
    ));
  }

  Future<AutoJoinStatusType> _startProcessingInternal(String ssid, String acmPassword) async {
    keepACMPassword(acmPassword);
    final isConnected = await _repository.checkConnectionWithModuleWithResult();
    if (isConnected) {
      // Already connected no need to try again
      if (await _repository.actionRequestCommissioningDataWithResult()) {
        // proceed as mac id success
        return AutoJoinStatusType.success;
      }
    }
    return await _tryAutoJoinAndFetchMacIdWithResult(ssid);
  }

  Future<AutoJoinStatusType> _tryAutoJoinAndFetchMacIdWithResult(String ssid) async {
    // Not connected to GE module so try to auto join
    AutoJoinStatusType autoJoinStatusType = await _startAutoJoin(ssid);
    if (autoJoinStatusType == AutoJoinStatusType.success) {
      if (await _repository.actionRequestCommissioningDataWithResult()) {
        // proceed as mac id success
        return AutoJoinStatusType.success;
      }
      return AutoJoinStatusType.fail; // mac id failed
    } else {
      return autoJoinStatusType;
    }
  }

  Future<AutoJoinStatusType> _startAutoJoin(String ssid) async {
    final result = await _repository.actionDirectStartAutoJoin(ssid);
    AutoJoinStatusType status = AutoJoinStatusType.none;
    if (result == "success") {
      status = AutoJoinStatusType.success;
    } else if (result == "fail") {
      status = AutoJoinStatusType.fail;
    } else if (result == "unsupport") {
      status = AutoJoinStatusType.unSupport;
    }
    return status;
  }

  void checkConnectedGeModuleSsid() async{
    final connectedNetworkSsid = await _actionCheckConnectedGeModuleSsid();
    emit(state.copyWith(
        seedValue: _seedValue++,
        stateType: CommissioningStateType.CHECK_CONNECTED_GE_MODULE_SSID,
        connectedGeModuleSsid: connectedNetworkSsid));
  }

  Future<String> _actionCheckConnectedGeModuleSsid() async {
    final networkSsid = await _repository.actionCheckConnectedGeModuleSsid();
    return networkSsid;
  }

  void actionSetModuleNetworks(List<Map<String, String>>? networks) {
    _wifiLockerService.setNetworksFromModule(networks);
  }
}
