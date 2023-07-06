// file: rest_api_recipe_provider.dart
// date: Jul/25/2022
// brief: A class for rest api smarthq provider.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/models/execution_control_request.dart';
import 'package:smarthq_flutter_module/models/execution_control_response.dart';
import 'package:smarthq_flutter_module/models/execution_id_request.dart';
import 'package:smarthq_flutter_module/models/execution_id_response.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_request.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_response.dart';
import 'package:smarthq_flutter_module/models/recipe_capabilities_response.dart';
import 'package:smarthq_flutter_module/models/recipe_execution.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/client/recipes_client.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/token_interceptor.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';


class RestApiClientRecipeProvider {
  static const String tag = 'RestApiClientRecipeProvider: ';

  static const List <String> domains = RecipeDomains.StandMixerAutoSense;

  DioAdapter? _dioAdapter;
  late bool _showHttpInterceptor;
  Dio? _dio;
  late SharedDataManager _sharedDataManager;
  late NativeStorage _nativeStorage;

  static final RestApiClientRecipeProvider _manager = RestApiClientRecipeProvider._internal();
  RestApiClientRecipeProvider._internal();

  factory RestApiClientRecipeProvider({DioAdapter? dioAdapter, bool showHttpInterceptor = true}) {
    _manager._dioAdapter = dioAdapter;
    _manager._showHttpInterceptor = showHttpInterceptor;

    if (BuildEnvironment.forceLog != null) {
      _manager._showHttpInterceptor = BuildEnvironment.forceLog!;
    }
    _manager._sharedDataManager = GetIt.I.get<SharedDataManager>();
    _manager._nativeStorage = GetIt.I.get<NativeStorage>();

    return _manager;
  }


  Dio _createDio() {
    Dio dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio, _sharedDataManager));
    if (_showHttpInterceptor) dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    if (_dioAdapter != null) dio.httpClientAdapter = _dioAdapter!;
    CertificateManager().setCertificatePinning(dio);
    return dio;
  }

  void resetDioForUnitTesting() {
    _dio = null;
  }

  RecipeClient _getClient() {
    _dio = _dio ?? _createDio();
    return RecipeClient(_dio!, baseUrl: BuildEnvironment.config.apiHost);
  }

  Future<String> _getApplianceId() async {
    try {
      var applianceId = _nativeStorage.selectedAppliance;
      return applianceId!.split("_")[0].toUpperCase();
    } catch (e) {
      geaLog.debug(e);
      return "";
    }
  }

  Future<RecipeCapabilitiesResponse> requestRecipeCapabilities() async {
    String? applianceId = await _getApplianceId();
    geaLog.debug('requestRecipeCapabilities: applianceId: $applianceId');
    return _getClient().getRecipeCapabilities(applianceId).onError((error, stackTrace) {
      if (_dioAdapter == null) geaLog.debug('$domains:[requestRecipeCapabilities]-error: $error,\n -stacktrace:$stackTrace');
      throw RestApiError.refineError(error);
    });
  }

  Future<DiscoverRecipeResponse> requestDiscoverRecipe({required DiscoverRecipeRequest request}) async {
    return _getClient()
        .requestDiscoverRecipe(request)
        .onError((error, stackTrace) {
      if (_dioAdapter == null) geaLog.debug('$domains:[requestDiscoverRecipe]-error: $error,\n -stacktrace:$stackTrace');
      throw RestApiError.refineError(error);
    });
  }

  Future<RecipeResponse> requestRecipe(String recipeId) async {
    return _getClient().getRecipe(recipeId).onError((error, stackTrace) {
      if (_dioAdapter == null) geaLog.debug('$domains:[requestRecipe]-error: $error,\n -stacktrace:$stackTrace');
      throw RestApiError.refineError(error);
    });
  }

  Future<ExecutionIDResponse> requestExecutionID({required ExecutionIDRequest request}) async {
    String applianceId = await _getApplianceId();
    return _getClient().getExecutionID(
      recipeId: request.recipeId,
      applianceId: applianceId,
      data: request).onError((error, stackTrace) {
      if (_dioAdapter == null) geaLog.debug('$domains:[requestExecutionID]-error: $error,\n -stacktrace:$stackTrace');
      throw RestApiError.refineError(error);
    });
  }

  Future<ExecutionControlResponse> requestExecutionControl({required ExecutionControlRequest request}) async {
    return _getClient().getExecutionControl(
      executionId: request.executionId ?? '',
      data: request).onError((error, stackTrace) {
      if (_dioAdapter == null) geaLog.debug('$domains:[requestExecutionControl]-error: $error,\n -stacktrace:$stackTrace');
      throw RestApiError.refineError(error);
    });
  }

  Future<ExecutionResponse> requestExecution(String executionId) async {
    return _getClient().getExecution(executionId).onError((error, stackTrace) {
      if (_dioAdapter == null) geaLog.debug('$domains:[requestExecution]-error: $error,\n -stacktrace:$stackTrace');
      throw RestApiError.refineError(error);
    });
  }


}
