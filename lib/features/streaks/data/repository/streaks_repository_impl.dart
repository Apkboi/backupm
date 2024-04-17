import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/streaks/data/model/get_streaks_response.dart';
import 'package:mentra/features/streaks/domain/repository/steaks_repository.dart';

class StreaksRepositoryImpl extends StreaksRepository {
  final NetworkService _networkService;

  StreaksRepositoryImpl(this._networkService);

  @override
  Future<GetStreaksResponse> getStreaks() async {
    try {
      final response = await _networkService
          .call(UrlConfig.getStreaks, RequestMethod.get, data: {});
      return GetStreaksResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
