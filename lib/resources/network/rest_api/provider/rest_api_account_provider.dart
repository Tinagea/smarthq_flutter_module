// file: rest_api_account_provider.dart
// date: Nov/25/2021
// brief: A class for rest api smarthq provider.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/environment/device_environment.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/account_client_entity/ge_token_response.dart';
import 'package:smarthq_flutter_module/managers/certificate_manager.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/client/account_client.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';

class RestApiAccountProvider {
  static const String tag = "RestApiAccountProvider: ";

  DioAdapter? _dioAdapter;
  Dio? _dio;
  late bool _showHttpInterceptor;
  late SharedDataManager _sharedDataManager;

  static final RestApiAccountProvider _manager = RestApiAccountProvider._internal();
  RestApiAccountProvider._internal();

  factory RestApiAccountProvider({DioAdapter? dioAdapter, bool showHttpInterceptor = true}) {
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
    if(_showHttpInterceptor) dio.interceptors.add(
        LogInterceptor(requestBody:true, responseBody:true));
    if(_dioAdapter != null) dio.httpClientAdapter = _dioAdapter!;
    CertificateManager().setCertificatePinning(dio);
    return dio;
  }

  void resetDioForUnitTesting() {
    _dio = null;
  }

  AccountClient _getClient() {
    _dio = _dio ?? _createDio();
    return  AccountClient(_dio!, baseUrl: BuildEnvironment.config.accountHost);
  }

  Future<GeTokenResponse> requestGeToken() async {
    final mdt = await _sharedDataManager.getStringValue(SharedDataKey.mobileDeviceToken);
    return _getClient().requestGeToken(
        integration: BuildEnvironment.config.integration,
        clientId: BuildEnvironment.config.clientId,
        clientSecret: BuildEnvironment.config.clientSecret,
        mdt: mdt ?? "", userAgent: DeviceEnvironment().getUserAgent())
        .onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.debug("$tag:[requestGeToken]-error: $error,\n -stacktrace:$stackTrace");
      throw RestApiError.refineError(error);
    });
  }
}