// file: rest_api_client_mysmarthq_provider.dart
// date: Nov/25/2021
// brief: A class for rest api smarthq provider.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/environment/device_environment.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/account_commands_response.dart' hide Command;
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/command_request.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_information_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_setting_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_setting_rule_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/tag_name_response.dart';
import 'package:smarthq_flutter_module/managers/certificate_manager.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/client/client_mysmarthq_client.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/token_interceptor.dart';

class RestApiClientMySmartHQProvider {
  static const String tag = "RestApiClientMySmartHQProvider";

  DioAdapter? _dioAdapter;
  Dio? _dio;
  late bool _showHttpInterceptor;
  late SharedDataManager _sharedDataManager;

  static final RestApiClientMySmartHQProvider _manager = RestApiClientMySmartHQProvider._internal();
  RestApiClientMySmartHQProvider._internal();

  factory RestApiClientMySmartHQProvider({DioAdapter? dioAdapter, bool showHttpInterceptor = true}) {
    _manager._dioAdapter = dioAdapter;
    _manager._showHttpInterceptor = showHttpInterceptor;
    if (BuildEnvironment.forceLog != null) {
      _manager._showHttpInterceptor = BuildEnvironment.forceLog!;
    }
    _manager._sharedDataManager = GetIt.I.get<SharedDataManager>();
    return _manager;
  }

  Dio _createDio() {
    Dio dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio, _sharedDataManager));
    if(_showHttpInterceptor) dio.interceptors.add(
        LogInterceptor(requestBody:true, responseBody:true));
    if(_dioAdapter != null) dio.httpClientAdapter = _dioAdapter!;
    CertificateManager().setCertificatePinning(dio);
    return dio;
  }

  void resetDioForUnitTesting() {
    _dio = null;
  }

  ClientMySmartHQClient _getClient() {
    _dio = _dio ?? _createDio();
    return  ClientMySmartHQClient(_dio!, baseUrl: BuildEnvironment.config.clientMySmartHQApiHost);
  }

  Future<DeviceListResponse> getDeviceList() async {
    return _getClient().getDeviceList()
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getDeviceList]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<DeviceListResponse> getDeviceListByDeviceType(String deviceType) async {
    return _getClient().findDeviceByDeviceType(deviceType)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getDeviceListByDeviceType]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<DeviceListResponse> getDeviceByUpdId(String updId) async {
    return _getClient().findDeviceByUpdId(updId)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getDeviceByUpdId]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<DeviceInformationResponse> getDeviceInfo(String deviceId) async {
    return _getClient().getDeviceInformation(deviceId)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getDeviceInfo]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<DeviceSettingResponse> getNotificationSettingInfo(String deviceId) async {
    return _getClient().getNotificationSettingInformation(deviceId)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getNotificationSettingInfo]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<AccountCommandsResponse> getNotificationHistoryInfo(String deviceId) async {
    return _getClient().getNotificationHistoryInformation(
        deviceId,
        "cloud.smarthq.service.pushnotification",
        DeviceEnvironment().platformType == PlatformType.iOS
            ? "cloud.smarthq.device.mobile.ios"
            : "cloud.smarthq.device.mobile.android")
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getNotificationHistoryInfo]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<DeviceSettingRuleResponse> postNotificationSettingRule(String deviceId, String ruleId, bool ruleEnabled) async {
    return _getClient().postNotificationSettingRule(deviceId, ruleId,
        DeviceSettingRuleResponse(
            kind: 'device#setting',
            ruleEnabled: ruleEnabled))
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[postNotificationSettingRule]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<dynamic> postCommandPairingSensor(String deviceId) async {
    return _getClient().postCommand(CommandRequest(
      kind: "service#command",
      deviceId: deviceId,
      serviceType: "cloud.smarthq.service.toggle",
      domainType: "cloud.smarthq.domain.add",
      serviceDeviceType: "cloud.smarthq.device.bluetooth",
      command: Command(
          commandType: "cloud.smarthq.command.toggle.set",
          on: true
      )
    )).onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[postCommandPairingSensor]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<TagNameResponse> postNickName(String deviceId, String tagValue) {
    return _getClient().postNickName(
        deviceId,
        "device#tag",
        "nickname",
        tagValue)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[postNickName]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<dynamic> requestServiceInfo(String deviceId, String serviceId) async {
    return _getClient().requestServiceInformation(deviceId, serviceId)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[requestServiceInformation]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<dynamic> postCommandStartOTA(String deviceId) async {
    return _getClient().postCommand(CommandRequest(
        kind: "service#command",
        deviceId: deviceId,
        serviceType: "cloud.smarthq.service.firmware.v1",
        domainType: "cloud.smarthq.domain.firmware",
        serviceDeviceType: "cloud.smarthq.device.hub",
        command: Command(
            commandType: "cloud.smarthq.command.firmware.v1.upgrade"
        )
    )).onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[postCommandStartOTA]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }
}