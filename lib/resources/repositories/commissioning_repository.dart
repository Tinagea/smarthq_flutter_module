import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';

import 'package:smarthq_flutter_module/utils/log_util.dart';

abstract class CommissioningRepository {
  void listenChannel(CommissioningCubit cubit);

  void actionRequestAPT();
  void actionSaveACMPassword(String? password);
  void actionRequestGeModuleReachability(bool isOn);
  void actionRequestCommissioningData();
  void actionRequestNetworkList();
  void actionSaveSelectedNetworkInformation(String? ssid, String? securityType, String password);
  void actionStartCommissioning();
  void actionRequestRelaunch();
  void actionMoveToNativeBackPage();
  void actionCheckConnectedGeModuleWifi();
  void actionCommissioningSuccessful();
  void actionCancelCommissioning();
  Future<bool> checkConnectionWithModuleWithResult();
  Future<bool>  actionRequestCommissioningDataWithResult();
  Future<String> actionDirectStartAutoJoin(String ssid);
  Future<String> actionCheckConnectedGeModuleSsid();
}


class CommissioningRepositoryImpl extends CommissioningRepository {

  late ChannelManager _channelManager;
  CommissioningRepositoryImpl({required ChannelManager channelManager}) {
    _channelManager = channelManager;
  }

  void listenChannel(CommissioningCubit cubit) {
    _channelManager.getStream().listen((item) {
      geaLog.debug('Listen from Stream : item($item)');

      if (item is CommissioningChannelItem) {
        switch (item.type) {
          case CommissioningChannelListenType.APPLICATION_PROVISIONING_TOKEN:
            if (item.dataItem is ResponseChannelDataItem) {
              var response = item.dataItem as ResponseChannelDataItem;
              cubit.responseApplicationProvisioningToken(response.isSuccess);
            }
            break;

          case CommissioningChannelListenType.CONNECTED_GE_MODULE_WIFI:
            if (item.dataItem is ResponseConnectedWifiDataItem) {
              var response = item.dataItem as ResponseConnectedWifiDataItem;
              cubit.responseConnectedGeModuleWifi(response.isSuccess, response.reason);
            }
            break;

          case CommissioningChannelListenType.COMMISSIONING_DATA_RESPONSE:
            if (item.dataItem is ResponseChannelDataItem) {
              var response = item.dataItem as ResponseChannelDataItem;
              cubit.responseCommissioningData(response.isSuccess);
            }
            break;

          case CommissioningChannelListenType.RECOMMEND_SSID:
          // TODO: Handle this case.
            break;

          case CommissioningChannelListenType.NETWORK_LIST:
            if (item.dataItem is NetworkListChannelDataItem) {
              var response = item.dataItem as NetworkListChannelDataItem;
              cubit.responseNetworkList(response.networkList);
            }
            break;

          case CommissioningChannelListenType.PROGRESS_STEP:
            if (item.dataItem is ProgressStepChannelDataItem) {
              var response = item.dataItem as ProgressStepChannelDataItem;
              cubit.responseProgressStep(response.step, response.isSuccess);
            }
            break;

          case CommissioningChannelListenType.NETWORK_JOIN_STATUS_FAIL:
            cubit.responseNetworkJoinStatusFail();
            break;

          case CommissioningChannelListenType.CHECK_MODULE_STATUS_FROM_USER:
            cubit.responseCheckModuleStatusFromUser();
            break;
        }
      }
    });
  }

  void actionRequestAPT() {
    _channelManager.actionRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_REQUEST_APPLICATION_PROVISIONING_TOKEN,
        null);
  }

  void actionSaveACMPassword(String? password) {
    _channelManager.actionRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_SAVE_ACM_PASSWORD,
        {'acmpassword': password});
  }

  void actionRequestGeModuleReachability(bool isOn) {
    _channelManager.actionRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_REQUEST_GE_MODULE_REACHABILITY,
        {'isOn': isOn});
  }

  void actionRequestCommissioningData() {
    _channelManager.actionRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_REQUEST_COMMISSIONING_DATA,
        null);
  }

  void actionRequestNetworkList() {
    _channelManager.actionRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_REQUEST_NETWORK_LIST,
        null);
  }

  void actionSaveSelectedNetworkInformation(String? ssid, String? securityType, String password) {
    _channelManager.actionRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_SAVE_SELECTED_NETWORK_INFORMATION,
        {'ssid': ssid,
          'securityType': securityType,
          'password': password});
  }

  void actionStartCommissioning() {
    _channelManager.actionRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_START_COMMISSIONING,
        null);
  }

  void actionRequestRelaunch() {
    _channelManager.actionRequest(ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_REQUEST_RELAUNCH,
        null);
  }

  void actionMoveToNativeBackPage() {
    _channelManager.actionRequest(ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_MOVE_TO_NATIVE_BACK_PAGE,
        null);
  }

  void actionCheckConnectedGeModuleWifi() {
    _channelManager.actionRequest(ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_CHECK_CONNECTED_GE_MODULE_WIFI,
        null);
  }

  void actionCommissioningSuccessful() {
    _channelManager.actionRequest(ChannelType.commissioning, CommissioningChannelProfile.ACTION_COMMISSIONING_SUCCESSFUL, null);
  }

  void actionCancelCommissioning() {
    _channelManager.actionRequest(ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_CANCEL_COMMISSIONING,
        null);
  }

  Future<bool> checkConnectionWithModuleWithResult() async {
    final isConnected = await _channelManager.actionDirectRequest(ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_CHECK_CONNECTED_GE_MODULE_WIFI_WITH_RESULT,
        null) as bool;
    return isConnected;
  }

  Future<bool>  actionRequestCommissioningDataWithResult() async {
    final isMacIdAvailable = await _channelManager.actionDirectRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_REQUEST_COMMISSIONING_DATA_WITH_RESULT,
        null) as bool;

    return isMacIdAvailable;
  }

  Future<String> actionDirectStartAutoJoin(String ssid) async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_START_AUTO_JOIN, {'ssid': ssid});

    final result = response as String;
    return result;
  }

  Future<String> actionCheckConnectedGeModuleSsid() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.commissioning,
        CommissioningChannelProfile.ACTION_CHECK_CONNECTED_GE_MODULE_SSID, null);

    final networkSsid = response as String;
    return networkSsid;
  }
}