import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/features/settings/data/models/get_avatars_response.dart';
import 'package:mentra/features/settings/data/models/update_profile_response.dart';
import 'package:mentra/features/settings/data/models/upload_avatar_response.dart';
import 'package:mentra/features/settings/data/models/verify_passcode_response.dart';

abstract class SettingsRepository {
  Future<UpdateProfileResponse> updateProfile(
      {required String name, required int birthYear});

  Future<VerifyPasscodeResponse> verifyPasscode({required String passcode});

  Future<GetAvatarsResponse> getAvatars();

  Future<SuccessResponse> updatePasscode(
      {required String hash,
      required String passcode,
      required String passcodeConfirmation});

  Future<UploadAvatarResponse> uploadAvatar({
    required int avatarId,
    required String bgColor,
  });
}
