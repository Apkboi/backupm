import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/settings/data/models/get_avatars_response.dart';
import 'package:mentra/features/settings/data/models/update_profile_response.dart';
import 'package:mentra/features/settings/data/models/upload_avatar_response.dart';
import 'package:mentra/features/settings/data/models/verify_passcode_response.dart';
import 'package:mentra/features/settings/dormain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final NetworkService networkService;

  SettingsRepositoryImpl(this.networkService);

  @override
  Future<SuccessResponse> updatePasscode(
      {required String hash,
      required String passcode,
      required String passcodeConfirmation}) async {
    try {
      final response = await networkService
          .call(UrlConfig.updatePassword, RequestMethod.post, data: {
        "hash": hash,
        "passcode": passcode,
        "passcode_confirmation": passcodeConfirmation,
      });

      return SuccessResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdateProfileResponse> updateProfile(
      {required String name, required int birthYear}) async {
    try {
      final response = await networkService
          .call(UrlConfig.updateProfile, RequestMethod.post, data: {
        "birth_year": birthYear.toString(),
        "name": name,
      });

      return UpdateProfileResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyPasscodeResponse> verifyPasscode(
      {required String passcode}) async {
    try {
      final response = await networkService
          .call(UrlConfig.verifyPasscode, RequestMethod.post, data: {
        "passcode": passcode,
      });

      return VerifyPasscodeResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetAvatarsResponse> getAvatars() async {
    try {
      final response = await networkService.call(
        UrlConfig.getAvatars,
        RequestMethod.get,
      );

      return GetAvatarsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UploadAvatarResponse> uploadAvatar(
      {required int? avatarId, required String bgColor}) async {
    try {
      final response = await networkService.call(
          UrlConfig.uploadAvatar, RequestMethod.post,
          data: {"avatar_id": avatarId, "avatar_background_color": bgColor});

      return UploadAvatarResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SuccessResponse> deleteAccount(String reason) async {
    final response = await networkService.call(
        UrlConfig.deleteAccountEndpoint, RequestMethod.post,
        data: {"reason": reason});

    return SuccessResponse.fromJson(response.data);
  }

  @override
  Future<SuccessResponse> eraseData() async {
    final response = await networkService.call(
        UrlConfig.eraseDataEndpoint, RequestMethod.post);
    return SuccessResponse.fromJson(response.data);
  }
}
