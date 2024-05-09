import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/sentory/sentory_service.dart';
import 'package:mentra/core/services/time_zone/time_zone_service.dart';

import '../data/session_manager.dart';
import 'api_error.dart';
import 'url_config.dart';

/// description: A network provider class which manages network connections
/// between the app and external services. This is a wrapper around [Dio].
///
/// Using this class automatically handle, token management, logging, global

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

/// A top level function to print dio logs
void printDioLogs(Object object) {
  if (kDebugMode) {
    printWrapped(object.toString());
  }
}

class NetworkService {
  static const CONNECT_TIME_OUT = Duration(seconds: 30);
  static const RECEIVE_TIME_OUT = Duration(seconds: 30);

  Dio? dio;
  String? baseUrl, authToken;

  NetworkService({String? baseUrl, String? authToken}) {
    this.baseUrl = baseUrl;
    this.authToken = authToken;
    _initialiseDio();
  }

  /// Initialize essential class properties
  void _initialiseDio() {
    dio = Dio(BaseOptions(
      connectTimeout: CONNECT_TIME_OUT,
      receiveTimeout: RECEIVE_TIME_OUT,
      baseUrl: baseUrl ?? UrlConfig.coreBaseUrl,
    ));
    authToken ??= SessionManager.instance.authToken;
    dio!.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: printDioLogs,
    ));
    // dio!.interceptors.add(AppInterceptor(authToken ?? ''));
  }

  /// Factory constructor used mainly for injecting an instance of [Dio] mock
  NetworkService.test(this.dio);

  Future<Response> call(String path, RequestMethod method,
      {Map<String, dynamic>? queryParams,
      data,
      FormData? formData,
      ResponseType responseType = ResponseType.json,
      classTag = '',
      Options? options}) async {
    Response response;
    var params = queryParams ?? {};
    if (params.keys.contains("searchTerm")) {
      params["searchTerm"] = Uri.encodeQueryComponent(params["searchTerm"]);
    }
    if (params.keys.contains("page")) {
      params["page"] = Uri.encodeQueryComponent(params["page"]);
    }
    try {
      switch (method) {
        case RequestMethod.post:
          response = await dio!.post(path,
              queryParameters: params,
              data: data ?? formData,
              options: options ?? _getOptions());

          break;
        case RequestMethod.get:
          response = await dio!
              .get(path, queryParameters: params, options: _getOptions());
          break;
        case RequestMethod.put:
          response = await dio!.put(path,
              queryParameters: params, data: data, options: _getOptions());
          break;
        case RequestMethod.patch:
          response = await dio!.patch(path,
              queryParameters: params, data: data, options: _getOptions());
          break;
        case RequestMethod.delete:
          response = await dio!.delete(path,
              queryParameters: params, data: data, options: _getOptions());
          break;
        case RequestMethod.upload:
          response = await dio!.post(path,
              data: formData,
              queryParameters: params,
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                "Content-Disposition": "form-data",
                "Content-Type": "multipart/form-data",
              }),
              onSendProgress: (sent, total) {});
          break;
        case RequestMethod.uploadPut:
          response = await dio!.put(path,
              data: formData,
              queryParameters: params,
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                // "Content-Disposition": "form-data",
                // "Content-Type": "multipart/form-data",
              }),
              onSendProgress: (sent, total) {});
          break;

        case RequestMethod.putSecond:
          response = await dio!.put(path,
              data: data,
              queryParameters: params,
              options: Options(headers: {
                "Authorization": "Bearer ${SessionManager.instance.authToken}",
                "Content-Type": "application/json",
              }),
              onSendProgress: (sent, total) {});
          break;
      }

      if (response.data is List) {
        return response;
      } else {
        if (response.data['errors'] != null) {
          logger.i(response.data.toString());
          SentryService.captureException('${response.data}',
              stackTrace: StackTrace.current);
          var apiError = ApiError.fromResponse(response);
          return Future.error(apiError);
        } else {
          return response;
        }
      }
    } catch (error, stackTrace) {
      if (error is DioException) {
        if (error.response?.statusCode == 308) {
          logger.e(error.response?.headers);

          response = await dio!.post(
            error.response!.headers["location"]!.join().toString(),
            queryParameters: params,
            data: data,
            options: _getOptions(),
          );

          return response;
        }

        var apiError = ApiError.fromDio(error);

        SentryService.captureException(
            '${apiError.apiErrorModel?.msg}${apiError.errorDescription}',
            stackTrace: stackTrace);

        return Future.error(apiError, stackTrace);
      }

      logger.e(error.toString());

      var apiError = ApiError.unknown(error);
      if (apiError.errorType == 401) {}

      SentryService.captureException(
          '${apiError.apiErrorModel?.msg}${apiError.errorDescription}',
          stackTrace: stackTrace);
      return Future.error(apiError, stackTrace);
    }
  }

  _getOptions() {
    return Options(contentType: Headers.jsonContentType, headers: {
      HttpHeaders.authorizationHeader:
          "Bearer ${SessionManager.instance.authToken}",
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "timezone": TimezoneService().currentTimeZone
    });
  }
}

enum RequestMethod {
  post,
  get,
  put,
  patch,
  delete,
  upload,
  uploadPut,
  putSecond,
}
