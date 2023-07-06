
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_item.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'ble_commissioning_channel_profile.dart';
import 'channel_manager/channel_manager.dart';

class BleCommissioningChannelHandler extends ChannelHandler {
  BleCommissioningChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('BleCommissioning Listener Method call [${call.method}](${call.arguments})');

    switch (call.method) {

      case BleCommissioningChannelProfile.LISTEN_BLE_IBEACON_SCANNING_RESULT:
        if (call.arguments == null) {
          streamController.add(
              BleCommissioningChannelItem(
                  BleCommissioningChannelListenType.BLE_IBEACON_SCANNING_RESULT,
                  ApplianceTypesChannelDataItem(applianceErds: null)));
        }
        else {
          List<String> applianceTypes = [];
          call.arguments['applianceType'].forEach((element) {
            applianceTypes.add(element);
          });
          streamController.add(
              BleCommissioningChannelItem(
                  BleCommissioningChannelListenType.BLE_IBEACON_SCANNING_RESULT,
                  ApplianceTypesChannelDataItem(applianceErds: applianceTypes)));
        }
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_START_PAIRING_ACTION1_RESULT:
        geaLog.debug('state.isSuccess: ${call.arguments['isSuccess']}, state.applianceType: ${call.arguments['applianceType']}');
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_START_PAIRING_ACTION1_RESULT,
                StartPairingActionResultChannelDataItem(
                    applianceErd: call.arguments['applianceType'],
                    isSuccess: call.arguments['isSuccess'])));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_START_PAIRING_ACTION2_RESULT:
        geaLog.debug('state.isSuccess: ${call.arguments['isSuccess']}, state.applianceType: ${call.arguments['applianceType']}');
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_START_PAIRING_ACTION2_RESULT,
                StartPairingActionResultChannelDataItem(
                    applianceErd: call.arguments['applianceType'],
                    isSuccess: call.arguments['isSuccess'])));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_START_PAIRING_ACTION3_RESULT:
        geaLog.debug('state.isSuccess: ${call.arguments['isSuccess']}, state.applianceType: ${call.arguments['applianceType']}');
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_START_PAIRING_ACTION3_RESULT,
                StartPairingActionResultChannelDataItem(
                    applianceErd: call.arguments['applianceType'],
                    isSuccess: call.arguments['isSuccess'])));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_PROGRESS_STEP:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_PROGRESS_STEP,
                ProgressStepChannelDataItem(step: call.arguments['step'], isSuccess: call.arguments['isSuccess'])));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_NETWORK_JOIN_STATUS_FAIL:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_NETWORK_JOIN_STATUS_FAIL,
                ResponseChannelDataItem(isSuccess: false)));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_NETWORK_STATUS_DISCONNECT:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_NETWORK_STATUS_DISCONNECT,
                ResponseChannelDataItem(isSuccess: false)));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_DEVICE_STATE:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_DEVICE_STATE,
                BleStateChannelDataItem(state: call.arguments['state'])));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_NETWORK_LIST:
        geaLog.debug("BleCommissioningChannelProfile:elements - $call");
        List<Map<String, String>> networkList = [];
        call.arguments.forEach((element) {
          networkList.add(Map.from(element));
        });
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_NETWORK_LIST,
                NetworkListChannelDataItem(networkList: networkList)));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_DETECTED_SCANNING:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_DETECTED_SCANNING,
                DetectedScanningChannelDataItem(
                    scanType: call.arguments['scanType'],
                    advertisementIndex: call.arguments['advertisementIndex'],
                    applianceType: call.arguments['applianceType'])));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_FINISHED_SCANNING:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_FINISHED_SCANNING,
                ResponseChannelDataItem(isSuccess: true)));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_RETRY_PAIRING_RESULT:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_RETRY_PAIRING_RESULT,
                ResponseChannelDataItem(isSuccess: call.arguments['isSuccess'])));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_MOVE_TO_ROOT_COMMISSIONING_PAGE:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_MOVE_TO_ROOT_COMMISSIONING_PAGE,
                ResponseChannelDataItem(isSuccess: false)));
        break;

      case BleCommissioningChannelProfile.LISTEN_BLE_FAIL_TO_CONNECT:
        streamController.add(
            BleCommissioningChannelItem(
                BleCommissioningChannelListenType.BLE_FAIL_TO_CONNECT,
                ResponseChannelDataItem(isSuccess: false)));
        break;

      default:
        throw MissingPluginException();
    }
  }

}