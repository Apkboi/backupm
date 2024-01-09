// ignore_for_file: unused_catch_stack

import 'package:dio/dio.dart';
import 'package:collection/collection.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';

import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/navigation/routes.dart';


/// Helper class for converting [DioError] into readable formats
class ApiError {
  int? errorType = 0;
  ApiErrorModel? apiErrorModel;

  /// description of error generated this is similar to convention [Error.message]
  String? errorDescription;

  ApiError(this.errorDescription);

  factory ApiError.fromDio(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        logger.e('unknown');

        return ApiError('Request to API was cancelled');
      case DioExceptionType.connectionTimeout:
        logger.e('unknown');

        return ApiError('Connection timeout with API');
      case DioExceptionType.sendTimeout:
        return ApiError('Send timeout in connection with API');
      case DioExceptionType.receiveTimeout:
        return ApiError('Receive timeout in connection with API');
      case DioExceptionType.badResponse:
        return ApiError(_setCustomErrorMessage(dioError.response!));
      // return ApiError(
      //     'Received invalid status code: ${dioError.response?.statusCode}');
      case DioExceptionType.unknown:
        return ApiError(_setCustomErrorMessage(dioError.response!));

      default:
        return ApiError('Oops!, Something went wrong, Please try again');
    }
  }
  factory ApiError.unknown(dynamic dioError) {
    return ApiError('Oops!, Something went wrong, Please try again');
  }

  ApiError.fromResponse(Object? error) {
    if (error is Response) {
      _setCustomErrorMessage(error);
      _handleErr();
    } else {
      _handleErr();
      errorDescription = "Oops an error occurred, we are fixing it";
    }
  }

  _handleErr() {
    return errorDescription;
  }

  String extractDescriptionFromResponse(Response<dynamic>? response) {
    String message = "";
    try {
      if (response?.data != null && response?.data["message"] != null) {
        message = response?.data["message"];
        logger.e(message);

        if (message == 'Invalid Data') {
          final errors = response?.data["errors"] as List;
          message = errors.firstOrNull;
        }
      } else {
        message = response?.statusMessage ?? '';
      }
    } catch (error, stackTrace) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => '$errorDescription';
}

class ApiErrorModel {
  int? code;
  String? msg;
  bool? success;

  ApiErrorModel({
    this.code,
    this.msg,
    this.success,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        code: json["code"],
        msg: json["message"],
        success: json["success"],
      );
}

String _setCustomErrorMessage(Response error) {
  if (error.statusCode == 401) {

    CustomDialogs.error('Unauthorized');
    CustomRoutes.goRouter.goNamed(PageUrl.signIn);

    return 'Unauthorized';
  }

  final errorMessageList = <String>[];

  if (error.data['msg'] is String) {
    errorMessageList.add(error.data['msg']);

  }  if (error.data['message'] is String) {
    errorMessageList.add(error.data['message']);
  }

  if (error.data['errors'] is Map<String, dynamic>) {
    final errors = error.data['errors'] as Map<String, dynamic>;
    final errorMessages = errors.values
        .whereType<List>()
        .expand((messages) => messages.whereType<String>());
    errorMessageList.addAll(errorMessages);
  }

  if (error.data['data'] is String) {
    errorMessageList.add(error.data['data']);
  }
  return errorMessageList.join(', ');
}
