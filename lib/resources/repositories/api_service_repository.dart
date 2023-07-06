// file: rest_api_repository.dart
// date: Nov/25/2021
// brief: A class for rest api repository.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/appliance_list_response.dart';
import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_networks_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_mysmarthq_entity/token_associate_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_mysmarthq_entity/token_register_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_information_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/profile/rest_api_profile.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_api_mysmarthq_provider.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_api_provider.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_brand_contents_provider.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_client_mysmarthq_provider.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';

import 'package:smarthq_flutter_module/resources/repositories/data_item/network_data_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_alert_details_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_history_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_setting_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_version_item.dart';
import 'package:smarthq_flutter_module/resources/storage/api_service_storage.dart';

import 'package:smarthq_flutter_module/utils/extensions/string_extension.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/brand_contents_entity/notification_settings_response.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/details/push_notification_alert_details_maker.dart';

abstract class ApiServiceRepository {

  /// RELATED TO SMARTHQ DATA ///
  Future<DeviceListResponse> getDeviceList();
  Future<DeviceListResponse> getDeviceListByDeviceType(String deviceType);
  Future<String?> getDeviceIdByUpdId(String updId);
  Future<DeviceInformationResponse> getDeviceInfo(String deviceId);

  Future<dynamic> requestMixerOscillate(String applianceId, StandMixerOscillateRequest request);

  /// RELATED TO GATEWAY & SENSOR ///
  Future<bool> postPairSensor(String deviceId);
  Future<List<Devices>> fetchLeakSensorByGatewayId(String gatewayId);
  Future<bool> postNickName(String deviceId, String nickName);
  Future<List<Devices>> fetchGatewayList();

  /// RELATED TO APPLIANCE SUPPORT ///
  Future<bool> requestModelValidation(String? modelNumber);

  /// RELATED TO THE COMMON SETTING ///
  Future<String> getNotificationSettingAPIVersion(String applianceTypeDec, {bool useCache = true});
  Future<List<NotificationVersionItem>?> getNotificationAPIVersionList({bool useCache = true});
  Future<List<NotificationSettingItem>> getNotificationSettingInfo(String deviceId);
  Future<bool> postNotificationRule(String deviceId, String ruleId, bool ruleEnabled);

  Future<List<NotificationHistoryItem>?> getNotificationHistoryInfo(String deviceId);
  Future<NotificationAlertDetailsItem?> getAlertContent(
      String countryCode, String languageCode,
      String deviceType, String alertType,
      {bool useCache = true});


  /// RELATED TO THE WIFI LOCKER ///
  Future<NetworkListDataItem> requestSavedWifiNetworks();
  Future<String?> savedWifiNetwork(String ssid, String password, String? securityType);
  Future<void> updateWifiNetwork(String networkId, String ssid, String password, String securityType);
  Future<void> removeWifiNetwork(String networkId);

  /// RELATED TO THE OTA ///
  Future<String?> fetchOTAStatus(String deviceId);
  Future<bool> postStartOTA(String deviceId);

  /// RELATED TO THE PUSH NOTIFICATION ///
  /// Call to register the Push Token into GE Cloud.
  /// return type: String - tokenReceipt value.
  Future<String?> registerToken(String pushToken, String? tokenReceipt);
  /// Call to associate the Receipt Token into GE Cloud.
  /// return type: bool - success value.
  Future<bool> associateToken(String tokenReceipt);

  /// RELATED TO SHORTCUT ///
  Future<List<ApplianceListItem>?> getApplianceList();
}

class ApiServiceRepositoryImpl implements ApiServiceRepository {
  static const String tag = "ApiServiceRepositoryImpl: ";

  late ApiServiceStorage _apiServiceStorage;

  ApiServiceRepositoryImpl({
    required ApiServiceStorage apiServiceStorage
  }) {
    _apiServiceStorage = apiServiceStorage;
  }

  bool useLocalData() => BuildEnvironment.restApiCommunicationDataType == CommunicationDataType.local;

  @override
  Future<DeviceListResponse> getDeviceList() async {
    final response = await RestApiClientMySmartHQProvider().getDeviceList();
    return response;
  }

  @override
  Future<DeviceListResponse> getDeviceListByDeviceType(String deviceType) async {
    final response = await RestApiClientMySmartHQProvider().getDeviceListByDeviceType(deviceType);
    return response;
  }

  @override
  Future<String?> getDeviceIdByUpdId(String updId) async {
    String? deviceId;
    DeviceListResponse response = await RestApiClientMySmartHQProvider()
        .getDeviceByUpdId(updId.toUpperCase());

    if (response.devices != null && response.devices!.isNotEmpty) {
      deviceId = response.devices?.first.deviceId;
    }
    return deviceId;
  }

  @override
  Future<DeviceInformationResponse> getDeviceInfo(String deviceId) async {
    DeviceInformationResponse response = await RestApiClientMySmartHQProvider()
        .getDeviceInfo(deviceId);
    return response;
  }

  @override
  Future<String> getNotificationSettingAPIVersion(
      String applianceTypeDec,
      {bool useCache = true} ) async {

    var versionList = _apiServiceStorage.notificationVersionList;
    var apiVersion = 'v1';

    if (useCache == false || versionList == null) {
      versionList = await _getNotificationSettingAPIVersionNCaching();
    }
    apiVersion = _getNotificationSettingAPIVersionFromCache(applianceTypeDec, versionList);

    return apiVersion;
  }

  @override
  Future<List<NotificationVersionItem>?> getNotificationAPIVersionList({bool useCache = true}) async {
    var versionList = _apiServiceStorage.notificationVersionList;
    if (useCache == false || versionList == null) {
      versionList = await _getNotificationSettingAPIVersionNCaching();
    }
    return versionList;
  }

  Future<List<NotificationVersionItem>?> _getNotificationSettingAPIVersionNCaching() async {
    NotificationSettingsResponse? response;
    response = await RestApiBrandContentsProvider()
        .getNotificationSettingJson()
        .onError((error, stackTrace) {
      if (error is RestApiResponseError &&
          (error.statusCode == RestApiResponseCode.forbidden ||
              error.statusCode == RestApiResponseCode.notFound)) {
        return null;// the version should be set as 'v1' when the json info could not obtain.
      }
      return null;
    });

    List<NotificationVersionItem>? versionList;
    if (response != null) {
      versionList = <NotificationVersionItem>[];
      response.notificationSettings?.forEach((item) {
        versionList?.add(
            NotificationVersionItem(
                applianceTypeDec: item.applianceTypeDec,
                apiVersion: item.apiVersion
            ));
      });

      _apiServiceStorage.setNotificationVersionList = versionList;
    }

    return versionList;
  }

  String _getNotificationSettingAPIVersionFromCache(
      String applianceTypeDec,
      List<NotificationVersionItem>? cache) {

    var apiVersion = 'v1';

    if (cache != null) {
      final index = cache.indexWhere( (item) =>
      (item.applianceTypeDec.toString() == applianceTypeDec));
      if (index == -1) {
        apiVersion = 'v2';
      }
      else {
        final version = cache[index].apiVersion;
        if (version != null && version == 1) {
          apiVersion = 'v1';
        }
        else if (version != null && version == 2) {
          apiVersion = 'v2';
        }
      }
    }

    return apiVersion;
  }

  @override
  Future<List<NotificationSettingItem>> getNotificationSettingInfo(String deviceId) async {
    List<NotificationSettingItem> notificationSettingList = [];
    final response = await RestApiClientMySmartHQProvider()
        .getNotificationSettingInfo(deviceId);

    response.settings?.forEach((setting) {
      notificationSettingList.add(
        NotificationSettingItem(
          ruleId: setting.ruleId,
          title: setting.title,
          description: setting.description,
          ruleEnabled: setting.ruleEnabled
        )
      );
    });

    return notificationSettingList;
  }

  @override
  Future<List<NotificationHistoryItem>?> getNotificationHistoryInfo(String deviceId) async {

    final response = await RestApiClientMySmartHQProvider()
        .getNotificationHistoryInfo(deviceId);
    final historyItemList = response.commands?.map((history) {

      final deviceType = history.rule?.deviceType ?? '';
      final alertType = history.rule?.alertType ?? '';
      final detailsState = (deviceType.isNotEmpty && alertType.isNotEmpty)
          ? NotificationHistoryDetailsButtonStatus.initial
          : NotificationHistoryDetailsButtonStatus.shouldNotShow;

      return NotificationHistoryItem(
          deviceType: deviceType,
          alertType: alertType,
          commandDateTime: history.commandDateTime,
          pushText: history.command?.pushText,
          pushTitle: history.command?.pushTitle,
          detailsState: detailsState);
    }).toList();
    return historyItemList;
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
      item = _apiServiceStorage.getNotificationAlertDetailsItem(key);
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

        _apiServiceStorage.setNotificationAlertDetailsItem(key, item);
      }
    }

    return item;
  }

  @override
  Future<bool> postNotificationRule(
      String deviceId, String ruleId, bool ruleEnabled) async {
    final response = await RestApiClientMySmartHQProvider()
        .postNotificationSettingRule(deviceId, ruleId, ruleEnabled);

    return response.ruleEnabled ?? false;
  }

  @override
  Future<NetworkListDataItem> requestSavedWifiNetworks() async {
    List<NetworkDataItem> savedNetworkList = [];

    WifiNetworksResponse response = await RestApiApiProvider().getWifiNetworks();

    var idValue = 0;
    response.networks?.forEach((element) {
      var securityType = "";
      if (element.type != null) {
        securityType = element.type!;
      }

      var ssid = "";
      if (element.ssid != null) {
        var ssidByte = base64.decode(element.ssid!);
        var ssidValue = utf8.decode(ssidByte);
        ssid = ssidValue;
      }

      savedNetworkList.add(
          NetworkDataItem(
              id: idValue++,
              networkId: element.networkId,
              ssid: ssid,
              password: element.password,
              securityType: securityType ));
    });

    return NetworkListDataItem(networks: savedNetworkList);
  }

  @override
  Future<String?> savedWifiNetwork(String ssid, String password, String? securityType) async {
    var ssidBytes = utf8.encode(ssid.trim());
    var ssidBase64Str = base64.encode(ssidBytes);
    ssidBase64Str = ssidBase64Str.replaceAll('AA', ''); // remove null value
    final networks = await RestApiApiProvider().postWifiNetwork(ssidBase64Str, password, securityType);
    return networks.networkId;
  }

  @override
  Future<void> updateWifiNetwork(String networkId, String ssid, String password, String securityType) async {
    var ssidBytes = utf8.encode(ssid);
    var ssidBase64Str = base64.encode(ssidBytes);
    final _ = await RestApiApiProvider().putWifiNetwork(networkId, ssidBase64Str, password, securityType);
  }

  @override
  Future<void> removeWifiNetwork(String networkId) async {
    final _ = await RestApiApiProvider().deleteWifiNetwork(networkId);
  }

  @override
  Future<bool> postPairSensor(String deviceId) async {
    var isSuccess = false;
    dynamic errorResponse;
    final response = await RestApiClientMySmartHQProvider()
        .postCommandPairingSensor(deviceId).catchError((onError) {
      errorResponse = onError;
    });

    if (errorResponse == null) {
      isSuccess = response["success"];
    }
    else {
      if (errorResponse is RestApiResponseError) {
        final error = errorResponse as RestApiResponseError;
        geaLog.debug("RestApiResponseError statusCode: ${error.statusCode}");
      }
    }
    return isSuccess;
  }

  @override
  Future<List<Devices>> fetchLeakSensorByGatewayId(String gatewayId) async {
    List<Devices> sensorList = [];
    DeviceListResponse response = await RestApiClientMySmartHQProvider()
        .getDeviceListByDeviceType(CloudDeviceSpec.deviceTypeLeakSensor);

    if (response.devices != null && response.devices!.isNotEmpty) {
      final result = response.devices!
          .where((device) => (device.gatewayId?.toLowerCase() == gatewayId.toLowerCase())).toList();

      if (result.isNotEmpty) {
        sensorList.addAll(result);
      }
    }

    return sensorList;
  }

  @override
  Future<bool> postNickName(String deviceId, String tagValue) async {
    final response = await RestApiClientMySmartHQProvider().postNickName(deviceId, tagValue);
    var isSuccess = false;
    if (response.success != null) {
      isSuccess = response.success!;
    }
    return isSuccess;
  }

  @override
  Future<List<Devices>> fetchGatewayList() async {
    List<Devices> gatewayList = [];
    DeviceListResponse response = await RestApiClientMySmartHQProvider()
        .getDeviceListByDeviceType(CloudDeviceSpec.deviceTypeHub);

    if (response.devices != null && response.devices!.isNotEmpty) {
      final result = response.devices!.where((device) => (
          device.productName?.toLowerCase() ==
              CloudDeviceSpec.productNameGateway.toLowerCase())).toList();

      if (result.isNotEmpty) {
        gatewayList.addAll(result);
      }
    }

    return gatewayList;
  }
  
  @override
  Future<String?> fetchOTAStatus(String deviceId) async {
    final deviceInfo = await getDeviceInfo(deviceId);
    final otaService = deviceInfo.services?.firstWhere((service) {
      return service.serviceType == 'cloud.smarthq.service.firmware.v1' &&
          service.domainType == 'cloud.smarthq.domain.firmware';
    });
    final upgradeStatus = otaService?.state?.upgradeStatus;
    if (upgradeStatus != null) {
      final status = upgradeStatus.split(".").last;
      return status;
    }

    return null;
  }

  @override
  Future<bool> postStartOTA(String deviceId) async {
    var isSuccess = false;
    dynamic errorResponse;
    final response = await RestApiClientMySmartHQProvider()
        .postCommandStartOTA(deviceId).catchError((onError) {
      errorResponse = onError;
    });

    if (errorResponse == null) {
      isSuccess = response["success"];
    }
    else {
      if (errorResponse is RestApiResponseError) {
        final error = errorResponse as RestApiResponseError;
        geaLog.debug("RestApiResponseError statusCode: ${error.statusCode}");
      }
    }
    return isSuccess;
  }

  @override
  Future<String?> registerToken(String pushToken, String? tokenReceipt) async {
    TokenRegisterResponse response = await RestApiApiMySmartHQProvider()
        .registerToken(pushToken, tokenReceipt);

    return response.tokenReceipt;
  }

  @override
  Future<bool> associateToken(String tokenReceipt) async {
    var result = false;

    TokenAssociateResponse response = await RestApiApiMySmartHQProvider()
        .associateToken(tokenReceipt);

    if (response.status != null &&
        response.status!.toLowerCase().compareTo("success") == 0)
      result = true;

    return result;
  }

  @override
  Future<bool> requestModelValidation(String? modelNumber) async {
    if (modelNumber == null) {
      return false;
    }

    final expectedLength = modelNumber.substring(0, 2);
    final length = int.parse(expectedLength, radix: 16) * 2;
    bool? valid = false;

    if (length > 0 && length < modelNumber.length) {
      final convertedModelNumber = (modelNumber.substring(2, 2 + length)).hexToAscii(length);
      geaLog.debug("requestModelValidation: convertedModelNumber = $requestModelValidation");

      final response = await RestApiApiProvider()
          .validateModelNumber(convertedModelNumber)
          .catchError((onError){
            valid = false;
          }
      );

      if(response == null) {
        valid = false;
      } else {
        valid = response.valid;
      }
    } else {
      valid = false;
    }

    return valid ?? false;
  }
  
  @override
  Future<dynamic> requestMixerOscillate(String applianceId, StandMixerOscillateRequest request) async {
    final response = RestApiApiProvider().requestMixerOscillate(applianceId, request);
    return response;
  }

  @override
  Future<List<ApplianceListItem>?> getApplianceList() async {
    ApplianceListResponse response = await RestApiApiProvider()
        .getApplianceList();
    return response.items;
  }
}