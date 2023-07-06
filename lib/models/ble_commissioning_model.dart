import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/network_data_item.dart';

enum BleCommissioningStateType {
  INITIAL,
  SHOW_PAIRING_LOADING,
  HIDE_PAIRING_LOADING,
  SHOW_CLOUD_LOADING,
  HIDE_CLOUD_LOADING,
  SHOW_SCAN_INDICATOR,
  NETWORK_JOIN_STATUS_FAIL,
  NETWORK_STATUS_DISCONNECT,
  NETWORK_LIST_INITIAL,
  NETWORK_LIST,
  PROGRESS,
  MOVE_TO_CATEGORY_PAGE,
  SCAN_RESULT,
  START_PAIRING_ACTION1_RESULT,
  START_PAIRING_ACTION2_RESULT,
  START_PAIRING_ACTION3_RESULT,
  RETRY_PAIRING_RESULT,
  SCAN_NETWORK_LIST,
  MOVE_TO_ROOT_COMMISSIONING_PAGE,
  FAIL_TO_CONNECT,
  WIFI_LOCKER_NETWORKS,
  SAVED_WIFI_LOCKER_NETWORKS,
  UPDATES_FINISHED,
  START_PAIRING_SENSOR_RESULT,
  PAIRING_SENSOR_COMPLETE_RESULT,
  POST_NICKNAME_RESULT,
  MOVE_TO_PAIR_SENSOR_PAGE,
  MOVE_TO_GATEWAY_STARTED_PAGE,
  MOVE_TO_SELECT_GATEWAY_PAGE,
  MOVE_TO_SELECT_GATEWAY_LIST_PAGE
}

class GatewayInfo {
  String? nickname;
  String? deviceId;
  String? gatewayId;

  GatewayInfo(
      this.nickname,
      this.deviceId,
      this.gatewayId);
}


class BleCommissioningState extends Equatable {
  const BleCommissioningState({
    this.seedValue,
    this.stateType,
    this.gatewayInfoList,
    this.applianceType,
    this.isSuccess,
    this.menuState,
    this.showNearbyIndicator,
    this.menuDataApplianceNames,
    this.menuDataApplianceTypes,
    this.networkListFromWifiModule,
    this.progressStep,
    this.savedWifiNetworks,
    this.areUpdatesFinished,
    this.isSuccessToStartParingSensor,
    this.isSuccessToCompleteParingSensor,
    this.isSuccessToPostNickName
  });

  final int? seedValue;
  final BleCommissioningStateType? stateType;
  final List<GatewayInfo>? gatewayInfoList;
  final ApplianceType? applianceType;
  final bool? isSuccess;
  final AddApplianceMenuState? menuState;
  final bool? showNearbyIndicator;
  final List<String>? menuDataApplianceNames;
  final List<ApplianceType>? menuDataApplianceTypes;

  final List<Map<String, String>>? networkListFromWifiModule;
  final Map<String, dynamic>? progressStep;
  final bool? isSuccessToStartParingSensor;
  final bool? isSuccessToCompleteParingSensor;
  final bool? isSuccessToPostNickName;

  final NetworkListDataItem? savedWifiNetworks;

  final bool? areUpdatesFinished;

  @override
  // TODO: implement props
  List<Object?> get props => [
    seedValue,
    stateType,
    gatewayInfoList,
    applianceType,
    isSuccess,
    menuState,
    showNearbyIndicator,
    menuDataApplianceNames,
    menuDataApplianceTypes,
    networkListFromWifiModule,
    progressStep,
    savedWifiNetworks,
    areUpdatesFinished,
    isSuccessToStartParingSensor,
    isSuccessToCompleteParingSensor,
    isSuccessToPostNickName
  ];

  @override
  String toString() => "BleCommissioningState {"
      "seedValue: $seedValue\n"
      "stateType: $stateType\n"
      "gatewayInfoList: $gatewayInfoList\n"
      "applianceType: $applianceType\n"
      "isSuccess: $isSuccess\n"
      "menuState: $menuState\n"
      "showNearbyIndicator: $showNearbyIndicator\n"
      "menuDataApplianceNames: $menuDataApplianceNames\n"
      "menuDataApplianceTypes: $menuDataApplianceTypes\n"
      "networkListFromWifiModule: $networkListFromWifiModule\n"
      "progressStep: $progressStep\n"
      "savedWifiNetworks: $savedWifiNetworks\n"
      "areUpdatesFinished: $areUpdatesFinished\n"
      "isSuccessToStartParingSensor: $isSuccessToStartParingSensor\n"
      "isSuccessToCompleteParingSensor: $isSuccessToCompleteParingSensor\n"
      "isSuccessToPostNickName: $isSuccessToPostNickName\n"
      "}";

  BleCommissioningState copyWith({
    int? seedValue,
    BleCommissioningStateType? stateType,
    List<GatewayInfo>? gatewayInfoList,
    ApplianceType? applianceType,
    bool? isSuccess,
    AddApplianceMenuState? menuState,
    bool? showNearbyIndicator,
    List<String>? menuDataApplianceNames,
    List<ApplianceType>? menuDataApplianceTypes,
    List<Map<String, String>>? networkListFromWifiModule,
    Map<String, dynamic>? progressStep,
    NetworkListDataItem? savedWifiNetworks,
    bool? areUpdatesFinished,
    bool? isSuccessToStartParingSensor,
    bool? isSuccessToCompleteParingSensor,
    bool? isSuccessToPostNickName
  }) {
    return BleCommissioningState(
        seedValue: seedValue ?? this.seedValue,
        stateType: stateType ?? this.stateType,
        gatewayInfoList: gatewayInfoList ?? this.gatewayInfoList,
        applianceType: applianceType ?? this.applianceType,
        isSuccess: isSuccess ?? this.isSuccess,
        menuState: menuState ?? this.menuState,
        showNearbyIndicator: showNearbyIndicator ?? this.showNearbyIndicator,
        menuDataApplianceNames: menuDataApplianceNames ?? this.menuDataApplianceNames,
        menuDataApplianceTypes: menuDataApplianceTypes ?? this.menuDataApplianceTypes,
        networkListFromWifiModule: networkListFromWifiModule ?? this.networkListFromWifiModule,
        progressStep: progressStep ?? this.progressStep,
        savedWifiNetworks: savedWifiNetworks ?? this.savedWifiNetworks,
        areUpdatesFinished: areUpdatesFinished ?? this.areUpdatesFinished,
        isSuccessToStartParingSensor: isSuccessToStartParingSensor ?? this.isSuccessToStartParingSensor,
        isSuccessToCompleteParingSensor: isSuccessToCompleteParingSensor ?? this.isSuccessToCompleteParingSensor,
        isSuccessToPostNickName: isSuccessToPostNickName ?? this.isSuccessToPostNickName
    );
  }
}