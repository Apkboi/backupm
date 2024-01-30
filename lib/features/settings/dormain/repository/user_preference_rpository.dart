import 'package:mentra/common/models/success_response.dart';

abstract class UserPreferenceRepository {
  Future<SuccessResponse> updatePreferences({required Map<String, dynamic> preferences});
}