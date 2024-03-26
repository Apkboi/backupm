import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/settings/dormain/repository/user_preference_rpository.dart';

class UserPreferenceRepositoryImpl extends UserPreferenceRepository {
  final NetworkService networkService;

  UserPreferenceRepositoryImpl(this.networkService);

  @override
  Future<SuccessResponse> updatePreferences(
      {required Map<String, dynamic> preferences}) async {
    try {
      final response = await networkService.call(
          UrlConfig.updatePreference, RequestMethod.post,
          data: preferences);

      return SuccessResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
