abstract class PasswordResetRepository {
  Future<dynamic> forgotPassword(String email);

  Future<dynamic> resetPassword(String password, String code);

  Future<dynamic> verifyOtp(String code, String email);
}
