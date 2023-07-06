import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';

import 'package:smarthq_flutter_module/utils/log_util.dart';

abstract class BleCommissioningRepository {

  void listenChannel(BleCommissioningCubit cubit);

  Future<List<String>?> actionDirectBleGetSearchedBeaconList();
  void actionBleMoveToWelcomePage(String applianceErd, String? subType);
  void actionBleGoToSetting();
  void actionBleStartIBeaconScanning();
  void actionBleStartPairingAction1(String applianceType);
  void actionBleStartPairingAction2(String applianceType);
  void actionBleStartPairingAction2List(List<String> applianceType);
  void actionBleStartPairingAction3(String? applianceType, int? advertisementIndex);
  void actionBleRequestNetworkList();
  void actionBleSaveSelectedNetworkInformation(String? ssid, String? securityType, String password);
  void actionBleSaveSelectedNetworkIndex(int? index);
  void actionBleStartCommissioning();
  void actionBleStartCommissioningOnlyModule();
  Future<String> actionDirectBleGetUpdId();
  void actionBleStartAllScanning();
  void actionBleStartAdvertisementScanning();
  void actionBleStopScanning();
  void actionBleRetryPairing();
  Future<String> actionDirectBleDeviceState();
  Future<dynamic> actionDirectBleGetInfoToPairSensor();
}


class BleCommissioningRepositoryImpl extends BleCommissioningRepository {

  late ChannelManager _channelManager;
  BleCommissioningRepositoryImpl({required ChannelManager channelManager}) {
    _channelManager = channelManager;
  }

  void listenChannel(BleCommissioningCubit cubit) {
    geaLog.debug("BleCommissioningRepositoryImpl:listenChannel is called");

    _channelManager.getStream().listen((item) {
      geaLog.debug('BleCommissioningRepositoryImpl:Listen from Stream: item($item)');

      if (item is BleCommissioningChannelItem) {
        switch (item.type) {

          case BleCommissioningChannelListenType.BLE_IBEACON_SCANNING_RESULT:
            if (item.dataItem is ApplianceTypesChannelDataItem) {
              var response = item.dataItem as ApplianceTypesChannelDataItem;
              cubit.responseBleIbeaconScanningResult(response.applianceErds);
            }
            break;

          case BleCommissioningChannelListenType
              .BLE_START_PAIRING_ACTION1_RESULT:
            if (item.dataItem is StartPairingActionResultChannelDataItem) {
              var response =
                  item.dataItem as StartPairingActionResultChannelDataItem;
              cubit.responseBleStartPairingAction1Result(
                  response.applianceErd, response.isSuccess);
            }
            break;

          case BleCommissioningChannelListenType
              .BLE_START_PAIRING_ACTION2_RESULT:
            if (item.dataItem is StartPairingActionResultChannelDataItem) {
              var response =
                  item.dataItem as StartPairingActionResultChannelDataItem;
              cubit.responseBleStartPairingAction2Result(
                  response.applianceErd, response.isSuccess);
            }
            break;

          case BleCommissioningChannelListenType
              .BLE_START_PAIRING_ACTION3_RESULT:
            if (item.dataItem is StartPairingActionResultChannelDataItem) {
              var response =
                  item.dataItem as StartPairingActionResultChannelDataItem;
              cubit.responseBleStartPairingAction3Result(
                  response.applianceErd, response.isSuccess);
            }
            break;

          case BleCommissioningChannelListenType.BLE_PROGRESS_STEP:
            if (item.dataItem is ProgressStepChannelDataItem) {
              var response = item.dataItem as ProgressStepChannelDataItem;
              cubit.responseProgressStep(response.step, response.isSuccess);
            }
            break;

          case BleCommissioningChannelListenType.BLE_NETWORK_JOIN_STATUS_FAIL:
            if (item.dataItem is ResponseChannelDataItem) {
              var _ = item.dataItem as ResponseChannelDataItem;
              cubit.responseBleNetworkJoinStatusFail();
            }
            break;

          case BleCommissioningChannelListenType.BLE_NETWORK_STATUS_DISCONNECT:
            if (item.dataItem is ResponseChannelDataItem) {
              var _ = item.dataItem as ResponseChannelDataItem;
              cubit.responseBleNetworkStatusDisconnected();
            }
            break;

          case BleCommissioningChannelListenType.BLE_DEVICE_STATE:
            if (item.dataItem is BleStateChannelDataItem) {
              var response = item.dataItem as BleStateChannelDataItem;
              cubit.responseBleDeviceState(response.state);
            }
            break;

          case BleCommissioningChannelListenType.BLE_NETWORK_LIST:
            if (item.dataItem is NetworkListChannelDataItem) {
              var response = item.dataItem as NetworkListChannelDataItem;
              cubit.responseNetworkList(response.networkList);
            }
            break;

          case BleCommissioningChannelListenType.BLE_DETECTED_SCANNING:
            if (item.dataItem is DetectedScanningChannelDataItem) {
              var response = item.dataItem as DetectedScanningChannelDataItem;
              cubit.responseDetectedScanning(response.scanType,
                  response.advertisementIndex, response.applianceType);
            }
            break;

          case BleCommissioningChannelListenType.BLE_FINISHED_SCANNING:
            if (item.dataItem is ResponseChannelDataItem) {
              var _ = item.dataItem as ResponseChannelDataItem;
              cubit.responseFinishedScanning();
            }
            break;

          case BleCommissioningChannelListenType.BLE_RETRY_PAIRING_RESULT:
            if (item.dataItem is ResponseChannelDataItem) {
              var response = item.dataItem as ResponseChannelDataItem;
              cubit.responseBleRetryPairing(response.isSuccess);
            }
            break;

          case BleCommissioningChannelListenType.BLE_MOVE_TO_ROOT_COMMISSIONING_PAGE:
            if (item.dataItem is ResponseChannelDataItem) {
              var _ = item.dataItem as ResponseChannelDataItem;
              cubit.responseBleMoveToRootCommissioningPage();
            }
            break;

          case BleCommissioningChannelListenType.BLE_FAIL_TO_CONNECT:
            if (item.dataItem is ResponseChannelDataItem) {
              var _ = item.dataItem as ResponseChannelDataItem;
              cubit.responseBleFailToConnect();
            }
            break;

          default:
            break;
        }
      }
    });
  }

  Future<List<String>?> actionDirectBleGetSearchedBeaconList() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_DIRECT_BLE_GET_SEARCHED_BEACON_LIST,
        null);

    List<String> applianceTypes = [];
    if (response != null) {
      response['applianceType'].forEach((element) {
        applianceTypes.add(element);
      });
    }

    if (applianceTypes.isEmpty) {
      return null;
    }

    return applianceTypes;
  }

  void actionBleMoveToWelcomePage(String applianceErd, String? subType) {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_MOVE_TO_WELCOME_PAGE,
        {'applianceType': applianceErd, 'subType': subType, 'isBleMode': true});
  }

  void actionBleGoToSetting() {
    _channelManager.actionRequest(ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_GO_TO_SETTING, null);
  }

  void actionBleStartIBeaconScanning() {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_IBEACON_SCANNING,
        {'durationSecTime': 30});
  }

  void actionBleStartPairingAction1(String applianceType) {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_PAIRING_ACTION1,
        {'applianceType': applianceType});
  }

  void actionBleStartPairingAction2(String applianceType) {
    geaLog.debug("BLE_BG => actionBleStartPairingAction2");
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_PAIRING_ACTION2,
        {'applianceType': [applianceType]});
  }

  void actionBleStartPairingAction2List(List<String> applianceTypes) {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_PAIRING_ACTION2,
        {'applianceType': applianceTypes});
  }

  void actionBleStartPairingAction3(String? applianceType, int? advertisementIndex) {
    _channelManager.actionRequest(ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_PAIRING_ACTION3, {
      'applianceType': applianceType,
      'advertisementIndex': advertisementIndex
    });
  }

  void actionBleRequestNetworkList() {
    _channelManager.actionRequest(ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_REQUEST_NETWORK_LIST, null);
  }

  void actionBleSaveSelectedNetworkInformation(String? ssid, String? securityType, String password) {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile
            .ACTION_BLE_SAVE_SELECTED_NETWORK_INFORMATION,
        {'ssid': ssid, 'securityType': securityType, 'password': password});
  }

  void actionBleSaveSelectedNetworkIndex(int? index) {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_SAVE_SELECTED_NETWORK_INDEX,
        {'index': index});
  }

  void actionBleStartCommissioning() {
    _channelManager.actionRequest(ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_COMMISSIONING, null);
  }

  void actionBleStartCommissioningOnlyModule() {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile
            .ACTION_BLE_START_COMMISSIONING_ONLY_MODULE,
        null);
  }

  Future<String> actionDirectBleGetUpdId() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_DIRECT_BLE_GET_UPD_ID,
        null);

    final updId = response['updId'];
    return updId;
  }

  void actionBleStartAllScanning() {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_ALL_SCANNING,
        {'durationSecTime': 30});
  }

  void actionBleStartAdvertisementScanning() {
    _channelManager.actionRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_START_ADVERTISEMENT_SCANNING,
        {'durationSecTime': 30});
  }

  void actionBleStopScanning() {
    _channelManager.actionRequest(ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_STOP_SCANNING, null);
  }

  void actionBleRetryPairing() {
    _channelManager.actionRequest(ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_BLE_RETRY_PAIRING, null);
  }

  Future<String> actionDirectBleDeviceState() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.bleCommissioning,
        BleCommissioningChannelProfile.ACTION_DIRECT_BLE_DEVICE_STATE,
        null);

    return response['state'];
  }

  Future<dynamic> actionDirectBleGetInfoToPairSensor() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.bleCommissioning, BleCommissioningChannelProfile.ACTION_DIRECT_BLE_GET_INFO_TO_PAIR_SENSOR, null);

    return response;
  }

}
