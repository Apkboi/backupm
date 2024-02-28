import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/authentication/password_reset/dormain/repository/password_reset_repository.dart';

class PasswordResetRepositoryImpl extends PasswordResetRepository {
  final NetworkService _networkService;

  PasswordResetRepositoryImpl(this._networkService);

  @override
  Future<SuccessResponse> forgotPassword(String email) async {
    try {
      final response = await _networkService.call(
          UrlConfig.forgotPassword, RequestMethod.post,
          data: {"email": email});
      return SuccessResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future resetPassword(String password, String hashKey) async {
    try {
      final response = await _networkService.call(
          UrlConfig.resetPassword, RequestMethod.post,
          data: {"password": password, "hash": hashKey});
      return response.data;
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future verifyOtp(String code, String email) async {
    try {
      final response = await _networkService
          .call(UrlConfig.verifyOtp, RequestMethod.post, data: {
        "email": email,
        "code": code,
      });
      return response.data;
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }
}
