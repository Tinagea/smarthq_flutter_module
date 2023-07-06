// file: rest_api_api_provider.dart
// date: Feb/21/2022
// brief: A class for rest api api provider.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/environment/device_environment.dart';
import 'package:smarthq_flutter_module/managers/certificate_manager.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/client/api_client.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/appliance_list_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/end_point_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/model_number_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_network_request.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_network_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_network_update_request.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_networks_response.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/token_interceptor.dart';

class RestApiApiProvider {
  static const String tag = "RestApiApiProvider: ";

  DioAdapter? _dioAdapter;
  Dio? _dio;
  late bool _showHttpInterceptor;
  late SharedDataManager _sharedDataManager;

  static final RestApiApiProvider _manager = RestApiApiProvider._internal();
  RestApiApiProvider._internal();

  factory RestApiApiProvider({DioAdapter? dioAdapter, bool showHttpInterceptor = true}) {
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

  ApiClient _getClient() {
    _dio = _dio ?? _createDio();
    return  ApiClient(_dio!, baseUrl: BuildEnvironment.config.apiHost);
  }

  Future<WifiNetworksResponse> getWifiNetworks() async {
    return _getClient().getWifiNetworks()
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[getWifiNetworks]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<WifiNetworkResponse> postWifiNetwork(String ssid, String password, String? securityType) async {
    return _getClient().postWifiNetwork(WifiNetworkRequest(
        ssid: ssid,
        password: password,
        type: securityType))
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[postWifiNetwork]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<dynamic> putWifiNetwork(String networkId, String ssid, String password, String securityTyp) async {
    return _getClient().putWifiNetwork(networkId, WifiNetworkUpdateRequest(
      kind: 'wifi#update',
      ssid: ssid,
      password: password))
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[putWifiNetwork]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<dynamic> deleteWifiNetwork(String networkId) async {
    return _getClient().deleteWifiNetwork(networkId)
        .onError((error, stackTrace) {
          if (_dioAdapter == null) geaLog.error("$tag:[deleteWifiNetwork]-error", error: error);
          throw RestApiError.refineError(error);
    });
  }

  Future<EndPointResponse> getEndPoint() async {
    return _getClient().getEndPoint(
        userAgent:DeviceEnvironment().getUserAgent())
        .onError((error, stackTrace) {
          if(_dioAdapter == null) geaLog.debug("$tag:[requestGeToken]-error: $error,\n -stacktrace:$stackTrace");
          throw RestApiError.refineError(error);
    });
  }

  Future<ModelNumberResponse?> validateModelNumber(String value) async {
    return _getClient().getModelValidation(value)
        .onError((error, stackTrace) {
          if (_dioAdapter == null) geaLog.error("$tag:[validateModelNumber]-error", error: error);
          throw RestApiError.refineError(error);
    });
  }

  Future<dynamic> requestMixerOscillate(String applianceID, StandMixerOscillateRequest request) async {
    return _getClient().requestMixerOscillate(applianceID, request)
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[requestFeatureInfo]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<ApplianceListResponse> getApplianceList() async {
    return _getClient().getApplianceList()
        .onError((error, stackTrace) {
      if (_dioAdapter == null) geaLog.error(
          "$tag:[getApplianceList]-error", error: error);
      throw RestApiError.refineError(error);
    });
  }
}