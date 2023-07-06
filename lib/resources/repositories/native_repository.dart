import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/storage/storages.dart';


enum NativeScreen {
   selfHelp
}

abstract class NativeRepository {
  void addObserver(NativeChannelObserver observer);
  void removeObserver(NativeChannelObserver observer);

  Future<void> moveToFlutterViewScreen({
    required RoutingType routingType,
    RoutingParameter? routingParameter});

  Future<String> getMdt();
  Future<String> getGeToken();
  Future<String> getPushToken();
  Future<String> getLanguagePreference();
  Future<String?> getSelectedApplianceId();

  Future<void> readyToService();

  Future<void> showTopBar(bool show);
  Future<void> showBottomBar(bool show);

  Future<void> moveToModelNumberValidationScreen();

  Future<UserCountryCodeState> actionDirectRequestUserCountryCode();

  Future<String> getCountryCode();

  Future<void> moveToOfflineScreen();
}

abstract class NativeChannelObserver {
  void onReceivedItem(NativeChannelListenType type, ChannelDataItem? item);
}

class NativeRepositoryImpl extends NativeRepository {
  static const String tag = "NativeRepositoryImpl:";

  final List<NativeChannelObserver> _observers = [];
  late ChannelManager _channelManager;
  late NativeStorage _nativeStorage;

  NativeRepositoryImpl({
    required ChannelManager channelManager,
    required NativeStorage nativeStorage}) {
    _nativeStorage = nativeStorage;
    _channelManager = channelManager;
    _channelManager.getStream().listen((item) {
      geaLog.debug('Listen from Stream: item($item)');

      if (item is NativeChannelItem) {
        _observers.forEach((element) {
          element.onReceivedItem(item.type, item.dataItem);
        });
      }
    });
  }

  void addObserver(NativeChannelObserver observer) {
    _observers.add(observer);
  }

  void removeObserver(NativeChannelObserver observer) {
    _observers.remove(observer);
  }

  @override
  Future<void> moveToFlutterViewScreen({
    required RoutingType routingType,
    RoutingParameter? routingParameter}) async {

    await _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_MOVE_TO_FLUTTER_VIEW_SCREEN,
        {
          'routingName': routingType.name,
          'routingParameter': routingParameter?.toJson()});
  }

  Future<String> getMdt() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.native, NativeChannelProfile.F2N_DIRECT_GET_MDT, null);

    return response['mdt'];
  }

  Future<String> getGeToken() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.native, NativeChannelProfile.F2N_DIRECT_GET_GE_TOKEN, null);

    return response['geToken'];
  }

  Future<String> getPushToken() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_GET_PUSH_TOKEN,
        null);

    return response['pushToken'];
  }

  Future<String> getLanguagePreference() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_GET_LANGUAGE_PREFERENCE,
        null);

    var languagePreference = 'en-US';
    if (response != null) {
      languagePreference = response['languagePreference'] ?? 'en-US';
    }
    geaLog.debug("languagePreference:$languagePreference");

    return languagePreference;
  }

  Future<String?> getSelectedApplianceId() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_GET_SELECTED_APPLIANCE_ID,
        null);
    if (response != null) {
      return response['selectedApplianceId'];
    } else {
      return null;
    }
  }

  Future<void> readyToService() async {
    await _channelManager.actionDirectRequest(ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_READY_TO_SERVICE, null);

    return;
  }

  Future<String> getCountryCode() async {
    dynamic userCountryCodeResponse = await _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_REQUEST_USER_COUNTRY_CODE,
        null);

    final countryCode = userCountryCodeResponse['countryCode'] ?? CountryUtil.us;
    _nativeStorage.setCountryCode = countryCode;
    geaLog.debug('userCountryCodeResponse: ($countryCode)');

    return countryCode;
  }

  Future<UserCountryCodeState> actionDirectRequestUserCountryCode() async {
    dynamic userCountryCodeResponse = await _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_REQUEST_USER_COUNTRY_CODE,
        null);

    return UserCountryCodeState(
      userCountryCodeResponse['countryCode'] ?? CountryUtil.us,
    );
  }

  Future<void> showTopBar(bool show) async {
    _channelManager.actionRequest(
        ChannelType.native, NativeChannelProfile.F2N_DIRECT_SHOW_HEADER, show);
  }

  Future<void> showBottomBar(bool show) async {
    _channelManager.actionRequest(
        ChannelType.native, NativeChannelProfile.F2N_DIRECT_SHOW_TAB_BAR, show);
  }

  Future<void> moveToModelNumberValidationScreen() async {
    _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_INVALID_MODEL_NUMBER, null);
  }

  Future<void> moveToOfflineScreen() async {
    _channelManager.actionDirectRequest(
        ChannelType.native,
        NativeChannelProfile.F2N_DIRECT_APPLIANCE_OFFLINE, null);
  }
}
