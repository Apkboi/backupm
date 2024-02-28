import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/journal/data/repository/journals_repository.dart';

class JournalsRepositoryImpl extends JournalsRepository {
  final NetworkService _networkService;

  JournalsRepositoryImpl(this._networkService);

  @override
  Future createJournal(payload) async {
    try {
      final response = await _networkService
          .call(UrlConfig.login, RequestMethod.post, data: payload.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteJournals(String id) async {
    try {
      final response = await _networkService
          .call(UrlConfig.login, RequestMethod.post, data: {"id": id});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getJournals() async {
    try {
      final response = await _networkService.call(
        UrlConfig.login,
        RequestMethod.get,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getPrompts() async {
    try {
      final response = await _networkService.call(
        UrlConfig.login,
        RequestMethod.get,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
