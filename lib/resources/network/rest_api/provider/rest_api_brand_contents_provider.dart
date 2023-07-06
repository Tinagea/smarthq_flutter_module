// file: rest_api_brand_contents_provider.dart
// date: Sep/03/2022
// brief: A class for rest api brand contents provider.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/managers/certificate_manager.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/client/brand_contents_client.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/brand_contents_entity/alert_content_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/brand_contents_entity/notification_settings_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/profile/rest_api_profile.dart' as restApiProfile;

class RestApiBrandContentsProvider {
  static const String tag = "RestApiBrandContentsProvider: ";

  DioAdapter? _dioAdapter;
  Dio? _dio;
  late bool _showHttpInterceptor;

  static final RestApiBrandContentsProvider _manager = RestApiBrandContentsProvider._internal();
  RestApiBrandContentsProvider._internal();

  factory RestApiBrandContentsProvider({DioAdapter? dioAdapter, bool showHttpInterceptor = true}) {
    _manager._dioAdapter = dioAdapter;
    _manager._showHttpInterceptor = showHttpInterceptor;
    if (BuildEnvironment.forceLog != null) {
      _manager._showHttpInterceptor = BuildEnvironment.forceLog!;
    }

    return _manager;
  }

  Dio _createDio() {
    Dio dio = Dio();
    if(_showHttpInterceptor) dio.interceptors.add(
        LogInterceptor(requestBody:true, responseBody:true));
    if(_dioAdapter != null) dio.httpClientAdapter = _dioAdapter!;
    CertificateManager().setCertificatePinning(dio);
    return dio;
  }

  void resetDioForUnitTesting() {
    _dio = null;
  }

  BrandContentsClient _getClient() {
    _dio = _dio ?? _createDio();
    return  BrandContentsClient(_dio!, baseUrl: BuildEnvironment.config.brandContentsHost);
  }

  Future<NotificationSettingsResponse?> getNotificationSettingJson() async {
    final response = await _getClient().getBrandContentsJson(
        '/${restApiProfile.CloudApiKey.apps}/${restApiProfile.CloudApiKey.appName}',
        restApiProfile.CloudApiKey.notificationSettings)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getNotificationSettingJson]-error", error:error);
      throw RestApiError.refineError(error);
    });

    final entity = NotificationSettingsResponse.fromJson(response);
    return entity;
  }

  Future<AlertContentResponse?> getAlertContentJson(
      String countryCode, String languageCode, String deviceType, String alertType) async {
    final response = await _getClient().getAlertContentsJson(
        countryCode, languageCode, deviceType, alertType + '.json')
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getAlertContentJson]-error", error:error);
      throw RestApiError.refineError(error);
    });

    final entity = AlertContentResponse.fromJson(response);
    return entity;
  }

}