// file: token_interceptor.dart
// date: Nov/25/2021
// brief: A class for rest api error.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:dio/dio.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/profile/rest_api_profile.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_account_provider.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';

class TokenInterceptor extends Interceptor {

  Dio _dio;
  SharedDataManager _sharedDataManager;
  TokenInterceptor(this._dio, this._sharedDataManager);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add Authorization Head
    final token = await _sharedDataManager.getStringValue(SharedDataKey.geToken);
    if (token != null) {
      options.headers["Authorization"] = "Bearer " + token;
      final contentType = options.headers["Content-Type"];
      if (contentType == null) {
        options.headers["Content-Type"] = CloudApiHeaderKey.contentTypeJson;
      }
      final accept = options.headers["Accept"];
      if (accept == null) {
        options.headers["Accept"] = CloudApiHeaderKey.contentTypeJson;
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // Handle Token Expired Error
    if (err.response?.statusCode == 401) {
      geaLog.debug("Token Expired!!");
      final response = await RestApiAccountProvider().requestGeToken();
      final geToken = response.accessToken;
      if (geToken != null) {
        geaLog.debug("Success to get new geToken: $geToken");
        await _sharedDataManager.setStringValue(SharedDataKey.geToken, geToken);
        err.requestOptions.headers["Authorization"] = "Bearer " + geToken;
        final options = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers);
        final cloneRequest = await _dio.request(
            err.requestOptions.baseUrl+err.requestOptions.path,
            options: options,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters);
        return handler.resolve(cloneRequest);
      }
      else {
        geaLog.debug("Fail to get geToken");
        return handler.next(err);
      }
    }
    else {
      return handler.next(err);
    }
  }
}