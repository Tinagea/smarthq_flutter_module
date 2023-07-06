import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_alert_details_item.dart';

import 'base_storage.dart';

abstract class DialogStorage extends Storage {
  String get countryCode;
  set setCountryCode(String countryCode);

  String get languageCode;
  set setLanguageCode(String languageCode);

  NotificationAlertDetailsItem? getNotificationAlertDetailsItem(String key);
  void setNotificationAlertDetailsItem(String key, NotificationAlertDetailsItem item);
}


class DialogStorageImpl extends DialogStorage {
  static const String tag = "DialogStorageImpl";
  DialogStorageImpl._();
  static final DialogStorageImpl _instance = DialogStorageImpl._();
  factory DialogStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.dialog;
  }

  String? _countryCode;
  @override
  String get countryCode => _countryCode!;
  @override
  set setCountryCode(String countryCode) => _countryCode = countryCode;

  String? _languageCode;
  @override
  String get languageCode => _languageCode!;
  @override
  set setLanguageCode(String languageCode) => _languageCode = languageCode;

  Map<String, NotificationAlertDetailsItem>? _notificationAlertDetailsItemMap;
  @override
  NotificationAlertDetailsItem? getNotificationAlertDetailsItem(String key) =>
      _notificationAlertDetailsItemMap?[key];
  @override
  void setNotificationAlertDetailsItem(String key, NotificationAlertDetailsItem item){
    if (_notificationAlertDetailsItemMap == null) {
      _notificationAlertDetailsItemMap = {};
    }
    _notificationAlertDetailsItemMap![key] = item;
  }
}