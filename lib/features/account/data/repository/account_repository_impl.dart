import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/account/data/model/account_response.dart';
import 'package:mentra/features/account/dormain/repository/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final NetworkService _networkService;

  AccountRepositoryImpl(this._networkService);

  @override
  Future<AccountResponse> getRemoteUser() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getProfile,
        RequestMethod.get,
      );

      return AccountResponse.fromJson(response.data);
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }
}
