import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_alert_details_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_version_item.dart';
import 'package:smarthq_flutter_module/resources/storage/base_storage.dart';

abstract class ApiServiceStorage extends Storage {

  List<NotificationVersionItem>? get notificationVersionList;
  set setNotificationVersionList(List<NotificationVersionItem> versionList);

  NotificationAlertDetailsItem? getNotificationAlertDetailsItem(String key);
  void setNotificationAlertDetailsItem(String key, NotificationAlertDetailsItem item);
}

class ApiServiceStorageImpl extends ApiServiceStorage {
  ApiServiceStorageImpl._();
  static final ApiServiceStorageImpl _instance = ApiServiceStorageImpl._();
  factory ApiServiceStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.apiService;
  }

  List<NotificationVersionItem>? _notificationVersionList;
  @override
  List<NotificationVersionItem>? get notificationVersionList => _notificationVersionList;
  @override
  set setNotificationVersionList(List<NotificationVersionItem> versionList) {
    if (_notificationVersionList == null) {
      _notificationVersionList = <NotificationVersionItem>[];
    }

    _notificationVersionList?.clear();
    versionList.forEach((item) {
      _notificationVersionList?.add(item.copyWith());
    });
  }

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