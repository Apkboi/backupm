import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/authentication/data/models/login_preview_response.dart';
import 'package:mentra/features/authentication/data/models/register_payload.dart';

abstract class AuthRepository {
  Future<AuthSuccessResponse> register(RegistrationPayload payload);

  Future<AuthSuccessResponse> login(String email, String password);

  Future sendOtp(String email);

  Future verifyOtp(String email, String otp);

  Future<LoginPreviewResponse> loginPreview(String email);
}
