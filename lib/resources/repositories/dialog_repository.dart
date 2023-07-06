import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_brand_contents_provider.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_alert_details_item.dart';
import 'package:smarthq_flutter_module/resources/storage/dialog_storage.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/details/push_notification_alert_details_maker.dart';

abstract class DialogRepository {
  void addObserver(DialogChannelObserver observer);
  void removeObserver(DialogChannelObserver observer);

  Future<String> getMdt();
  Future<String> getGeToken();

  Future<String> getLanguagePreference();
  Future<String> getCountryCode();

  Future<void> moveToFlutterViewScreen({
    required RoutingType routingType,
    RoutingParameter? routingParameter});

  Future<NotificationAlertDetailsItem?> getAlertContent(
      String countryCode, String languageCode,
      String deviceType, String alertType,
      {bool useCache = true});
}

abstract class DialogChannelObserver {
  void onReceivedItem(DialogChannelListenType type, ChannelDataItem? item);
}

class DialogRepositoryImpl extends DialogRepository {
  static const String tag = "DialogRepositoryImpl:";

  final List<DialogChannelObserver> _observers = [];
  late ChannelManager _channelManager;
  late DialogStorage _dialogStorage;

  DialogRepositoryImpl({
    required ChannelManager channelManager,
    required DialogStorage dialogStorage
  }) {
    _channelManager = channelManager;
    _channelManager.getStream().listen((item) {
      geaLog.debug('Listen from Stream: item($item)');

      if (item is DialogChannelItem) {
        _observers.forEach((element) {
          element.onReceivedItem(item.type, item.dataItem);
        });
      }
    });
    _dialogStorage = dialogStorage;
  }

  @override
  void addObserver(DialogChannelObserver observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(DialogChannelObserver observer) {
    _observers.remove(observer);
  }

  @override
  Future<String> getMdt() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.dialog, DialogChannelProfile.F2N_DIRECT_GET_MDT, null);

    return response['mdt'];
  }

  @override
  Future<String> getGeToken() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.dialog, DialogChannelProfile.F2N_DIRECT_GET_GE_TOKEN, null);

    return response['geToken'];
  }

  @override
  Future<String> getLanguagePreference() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.dialog,
        DialogChannelProfile.F2N_DIRECT_GET_LANGUAGE_PREFERENCE,
        null);

    var languagePreference = 'en-US';
    if (response != null) {
      languagePreference = response['languagePreference'] ?? 'en-US';
    }
    geaLog.debug("languagePreference:$languagePreference");

    return languagePreference;
  }

  @override
  Future<String> getCountryCode() async {
    dynamic response = await _channelManager.actionDirectRequest(
        ChannelType.dialog,
        DialogChannelProfile.F2N_DIRECT_REQUEST_USER_COUNTRY_CODE,
        null);

    final countryCode = response['countryCode'] ?? 'US';
    geaLog.debug('getCountryCode: $countryCode');

    return countryCode;
  }

  @override
  Future<void> moveToFlutterViewScreen({
    required RoutingType routingType,
    RoutingParameter? routingParameter}) async {

    await _channelManager.actionDirectRequest(
        ChannelType.dialog,
        DialogChannelProfile.F2N_DIRECT_MOVE_TO_FLUTTER_VIEW_SCREEN,
        {
          'routingName': routingType.name,
          'routingParameter': routingParameter?.toJson()});
  }

  @override
  Future<NotificationAlertDetailsItem?> getAlertContent(
      String countryCode, String languageCode,
      String deviceType, String alertType,
      {bool useCache = true}) async {

    NotificationAlertDetailsItem? item;

    final key = PushNotificationAlertDetailsMaker.makeKeyFrom(
        countryCode, languageCode, deviceType, alertType);
    var hasCacheData = false;
    if (useCache) {
      item = _dialogStorage.getNotificationAlertDetailsItem(key);
      hasCacheData = (item != null);
    }

    if (!hasCacheData) {
      final response = await RestApiBrandContentsProvider()
          .getAlertContentJson(countryCode, languageCode, deviceType, alertType)
          .catchError((onError) {
        return null;
      });

      if (response != null) {
        final title = response.title;
        final contentsItems = PushNotificationAlertDetailsMaker.makeContentItemsFrom(response);
        item = NotificationAlertDetailsItem(
            title: title,
            contentItems: contentsItems);

        _dialogStorage.setNotificationAlertDetailsItem(key, item);
      }
    }

    return item;
  }
}