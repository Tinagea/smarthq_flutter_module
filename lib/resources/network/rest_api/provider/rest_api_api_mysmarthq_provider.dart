// file: rest_api_api_mysmarthq_provider.dart
// date: Jul/19/2022
// brief: A class for rest api smarthq provider.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/managers/certificate_manager.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_mysmarthq_entity/token_associate_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_mysmarthq_entity/token_register_response.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/client/api_mysmarthq_client.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/token_interceptor.dart';

class RestApiApiMySmartHQProvider {
  static const String tag = "RestApiApiMySmartHQProvider: ";

  DioAdapter? _dioAdapter;
  Dio? _dio;
  late bool _showHttpInterceptor;
  late SharedDataManager _sharedDataManager;

  static final RestApiApiMySmartHQProvider _manager = RestApiApiMySmartHQProvider._internal();
  RestApiApiMySmartHQProvider._internal();

  factory RestApiApiMySmartHQProvider({DioAdapter? dioAdapter, bool showHttpInterceptor = true}) {
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

  ApiMySmartHQClient _getClient() {
    _dio = _dio ?? _createDio();
    return ApiMySmartHQClient(_dio!, baseUrl: BuildEnvironment.config.apiMySmartHQHost);
  }

  Future<TokenRegisterResponse> registerToken(String pushToken, String? tokenReceipt) async {
    return _getClient().registerToken(
        "push#register",
        Platform.isAndroid ? BuildEnvironment.config.appIdsAndroid : BuildEnvironment.config.appIdsIOS,
        pushToken,
        tokenReceipt
    ).onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[registerToken]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

  Future<TokenAssociateResponse> associateToken(String tokenReceipt) async {
    return _getClient().associateToken(
        "push#associate",
        tokenReceipt
    ).onError((error, stackTrace) {
      if(_dioAdapter == null) geaLog.error("$tag:[associateToken]-error", error:error);
      throw RestApiError.refineError(error);
    });
  }

}