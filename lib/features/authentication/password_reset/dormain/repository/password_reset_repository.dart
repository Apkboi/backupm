abstract class PasswordResetRepository {
  Future<dynamic> forgotPassword(String email);

  Future<dynamic> resetPassword(String password, String hashKey);

  Future<dynamic> verifyOtp(String code, String email);
}
