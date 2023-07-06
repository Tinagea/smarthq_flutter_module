// file: wifi_locker_model.dart
// date: Jun/11/2021
// brief: wifi locker model.
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

abstract class WifiLockerAction {
  final int id;

  const WifiLockerAction({required this.id});
}

class WifiLockerSaveAction extends WifiLockerAction {
  final String ssid;
  final String password;
  final String securityType;

  const WifiLockerSaveAction({
    required int id,
    required this.ssid,
    required this.password,
    required this.securityType}): super(id: id);
}

class WifiLockerDeleteAction extends WifiLockerAction {
  final String networkId;

  const WifiLockerDeleteAction({
    required int id,
    required this.networkId}): super(id: id);
}

class WifiLockerUpdateAction extends WifiLockerAction {
  final String networkId;
  final String ssid;
  final String password;
  final String securityType;

  const WifiLockerUpdateAction({
    required int id,
    required this.networkId,
    required this.ssid,
    required this.password,
    required this.securityType}): super(id: id);
}