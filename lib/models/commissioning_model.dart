import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';

enum CommissioningStateType {
  INITIAL,
  APT,
  CONNECTED_MODULE,
  COMMUNICATION_DATA,
  NETWORK_LIST_INITIAL,
  NETWORK_LIST,
  PROGRESS,
  AUTO_JOIN,
  NETWORK_JOIN_STATUS_FAIL,
  CHECK_MODULE_STATUS_FROM_USER,
  CHECK_CONNECTED_GE_MODULE_SSID
}

class CommissioningState extends Equatable {
  const CommissioningState({
    this.seedValue,
    this.stateType,
    this.isReceiveApplianceProvisioningToken,
    this.wifiModulePassword,
    this.isConnectedGeWifiModule,
    this.isSuccessCommunicatingWithWifiModule,
    this.recommendedWifiSsid,
    this.networkListFromWifiModule,
    this.progressStep,
    this.failReason,
    this.autoJoinStatusType,
    this.connectedGeModuleSsid
  });

  final int? seedValue;
  final CommissioningStateType? stateType;

  final bool? isReceiveApplianceProvisioningToken;
  final String? wifiModulePassword;

  final bool? isConnectedGeWifiModule;
  final bool? isSuccessCommunicatingWithWifiModule;

  final String? recommendedWifiSsid;

  final List<Map<String, String>>? networkListFromWifiModule;

  final Map<String, dynamic>? progressStep;

  final int? failReason;

  final AutoJoinStatusType? autoJoinStatusType;

  final String? connectedGeModuleSsid;
  @override
  List<Object?> get props => [
    seedValue,
    stateType,
    isReceiveApplianceProvisioningToken,
    wifiModulePassword,
    isConnectedGeWifiModule,
    isSuccessCommunicatingWithWifiModule,
    recommendedWifiSsid,
    networkListFromWifiModule,
    progressStep,
    failReason,
    autoJoinStatusType,
    connectedGeModuleSsid
  ];

  @override
  String toString() => "CommissioningState {"
      "seedValue: $seedValue\n"
      "stateType: $stateType\n"
      "isReceiveAppliancesProvisioningToken: $isReceiveApplianceProvisioningToken\n"
      "wifiModulePassword: $wifiModulePassword\n"
      "isConnectedGeWifiModule: $isConnectedGeWifiModule\n"
      "isSuccessCommunicatingWithWifiModule: $isSuccessCommunicatingWithWifiModule\n"
      "recommendedWifiSsid: $recommendedWifiSsid\n"
      "networkListFromWifiModule: $networkListFromWifiModule\n"
      "progressStep: $progressStep\n"
      "failReason: $failReason\n"
      "autoJoinStatusType: $autoJoinStatusType\n"
      "connectedGeModuleSsid: $connectedGeModuleSsid\n"
      "}";

  CommissioningState copyWith({
    int? seedValue,
    CommissioningStateType? stateType,
    bool? isReceiveApplianceProvisioningToken,
    String? wifiModulePassword,
    bool? isConnectedGeWifiModule,
    bool? isSuccessCommunicatingWithWifiModule,
    String? recommendedWifiSsid,
    List<Map<String, String>>? networkListFromWifiModule,
    Map<String, dynamic>? progressStep,
    Map<String, dynamic>? acmCredentials,
    int? failReason,
    AutoJoinStatusType? autoJoinStatusType,
    String? connectedGeModuleSsid
  }) {
    return CommissioningState(
        seedValue: seedValue ?? this.seedValue,
        stateType: stateType ?? this.stateType,
        isReceiveApplianceProvisioningToken: isReceiveApplianceProvisioningToken ?? this.isReceiveApplianceProvisioningToken,
        wifiModulePassword: wifiModulePassword ?? this.wifiModulePassword,
        isConnectedGeWifiModule: isConnectedGeWifiModule ?? this.isConnectedGeWifiModule,
        isSuccessCommunicatingWithWifiModule: isSuccessCommunicatingWithWifiModule ?? this.isSuccessCommunicatingWithWifiModule,
        recommendedWifiSsid: recommendedWifiSsid ?? this.recommendedWifiSsid,
        networkListFromWifiModule: networkListFromWifiModule ?? this.networkListFromWifiModule,
        progressStep: progressStep ?? this.progressStep,
        failReason: failReason ?? this.failReason,
        autoJoinStatusType: autoJoinStatusType??this.autoJoinStatusType,
        connectedGeModuleSsid: connectedGeModuleSsid ?? this.connectedGeModuleSsid
    );
  }
}

class UserCountryCodeState {
  final String userCountryCode;

  const UserCountryCodeState(this.userCountryCode);
}
