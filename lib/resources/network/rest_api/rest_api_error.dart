// file: rest_api_error.dart
// date: Nov/25/2021
// brief: A class for rest api error.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';


abstract class RestApiResponseCode {
  static const unspecified = 0;
  static const success = 200;

  static const badRequest = 400;
  static const notAuthorized = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const badPostRequest = 409;
  static const deviceAlreadyReserved = 412;
  static const tooManyRequests = 429;

  static const serverNotRespond = 500;
  static const serverNotRespondOAuth = 503;

  static const securityFailure = 1000;
  static const timeOut = -1001;
  static const connectionOffline = -1009;
  static const domainFailure = -1012;
  static const roamingOff = -1018;
}

enum RestApiTimeOutErrorType {
  timeOutConnect,
  timeOutSend,
  timeOutReceive
}

enum RestApiOtherErrorType {
  etcError,
  cancelError,
  defaultError,
  handshakeError,
  // certificateError, It was unified with handshakeError.
  socketError
}

enum RestApiAuth0ErrorType {
  cancelError,
  defaultError,
  customCodeError
}

class RestApiTimeOutError extends RestApiError {
  final RestApiTimeOutErrorType errorType;
  RestApiTimeOutError(this.errorType);

  @override
  StackTrace get stackTrace => throw StackTrace.current;
}

class RestApiResponseError extends RestApiError {
  final int statusCode;
  final String message;
  final String reason;

  RestApiResponseError(int? code, String? messageString, String? reasonString)
      : statusCode = code ?? -1,
        message = messageString ?? "-",
        reason = reasonString ?? "-";

  @override
  StackTrace get stackTrace => StackTrace.current;
}

class RestApiOtherError extends RestApiError {
  final RestApiOtherErrorType errorType;

  RestApiOtherError(this.errorType);

  @override
  StackTrace get stackTrace => throw StackTrace.current;
}

class RestApiAuth0Error extends RestApiError {
  final RestApiAuth0ErrorType errorType;

  RestApiAuth0Error(this.errorType);

  @override
  StackTrace get stackTrace => throw StackTrace.current;
}

class RestApiError extends Error {
  static const tag = "RestApiError: ";

  static RestApiError obtainErrorFrom(DioError error) {
    geaLog.error("${tag}obtainErrorFrom()");
    RestApiError restApiError = RestApiError();

    _printRequest(error);
    _printResponse(error);

    switch (error.type) {
    /// With the update to Dio 5.0, the following changes have been made:
    /// - response has been changed to BadResponse.
    /// - connectTimeout has been changed to connectionTimeout.
    /// - other has been changed to connectionError.
    /// - badCertificate has been added.
    ///   It is suspected that badCertificate occurs when there is a problem with the leaf certificate when ValidateCertificate is used.
    ///   ValidateCertificate is not currently used in the project, but it is being added in advance for future use.
    /// - CertificateException has also been added.
    ///   HandshakeException still detects certificate errors.
    ///   It is not clear exactly in which situations CertificateException occurs,
    ///   so both cases should be treated as Pinning errors.

      case DioErrorType.badResponse:
        var message = "";
        var reason = "";
        if(error.response?.data is Map<String, dynamic>) {
          message = error.response?.data?["message"] ?? "";
          reason = error.response?.data?["reason"] ?? "";
        }
        restApiError = RestApiResponseError(error.response?.statusCode, message.isEmpty ? error.message : message, reason);
        break;
      case DioErrorType.connectionTimeout:
        restApiError = RestApiTimeOutError(RestApiTimeOutErrorType.timeOutConnect);
        break;
      case DioErrorType.receiveTimeout:
        restApiError = RestApiTimeOutError(RestApiTimeOutErrorType.timeOutReceive);
        break;
      case DioErrorType.sendTimeout:
        restApiError = RestApiTimeOutError(RestApiTimeOutErrorType.timeOutSend);
        break;
      case DioErrorType.cancel:
        restApiError = RestApiOtherError(RestApiOtherErrorType.cancelError);
        break;
      case DioErrorType.connectionError:
        if (error.error is HandshakeException
            || error.error is CertificateException) {
          restApiError = RestApiOtherError(RestApiOtherErrorType.handshakeError);
        } else if (error.error is SocketException) {
          restApiError = RestApiOtherError(RestApiOtherErrorType.socketError);
        } else {
          restApiError = RestApiOtherError(RestApiOtherErrorType.etcError);
        }
        break;
      case DioErrorType.badCertificate: // For ValidateCertificate
        if (error.error is HandshakeException
            || error.error is CertificateException) {
          restApiError = RestApiOtherError(RestApiOtherErrorType.handshakeError);
        }
        break;
      default :
        if (error.error is HandshakeException
            || error.error is CertificateException) {
          restApiError = RestApiOtherError(RestApiOtherErrorType.handshakeError);
        } else if (error.error is SocketException) {
          restApiError = RestApiOtherError(RestApiOtherErrorType.socketError);
        } else {
          restApiError = RestApiOtherError(RestApiOtherErrorType.defaultError);
        }
        break;
    }

    return restApiError;
  }

  static void _printRequest(DioError error) {
    geaLog.error("$tag[REQUEST]\n"
        "{\n"
        " method: ${error.requestOptions.method}\n"
        " header: ${error.requestOptions.headers.toString()}\n"
        " data: ${error.requestOptions.data.toString()}\n"
        " baseUrl: ${error.requestOptions.baseUrl}\n"
        " path: ${error.requestOptions.path}\n"
        "}");
  }

  static void _printResponse(DioError error) {
    geaLog.error("$tag[RESPONSE]\n"
        "${error.response.toString()}\n");
  }

  static Error refineError(Object? error) {
    if(error is DioError){
      return RestApiError.obtainErrorFrom(error);
    }
    else {
      return RestApiOtherError(RestApiOtherErrorType.defaultError);
    }
  }
}
