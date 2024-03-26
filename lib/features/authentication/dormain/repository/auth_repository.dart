import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/authentication/data/models/login_preview_response.dart';
import 'package:mentra/features/authentication/data/models/oauth_req_dto.dart';
import 'package:mentra/features/authentication/data/models/onauth_response.dart';
import 'package:mentra/features/authentication/data/models/register_payload.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthRepository {
  Future<AuthSuccessResponse> register(RegistrationPayload payload);

  Future<AuthSuccessResponse> login(String email, String password);

  Future sendOtp(String email);

  Future verifyOtp(String email, String otp);

  Future<LoginPreviewResponse> loginPreview(String email);

  Future<GoogleSignInAuthentication?> googleAuth();

  Future<AuthorizationCredentialAppleID?> appleAuth();

  Future<OauthResponse> oauthSignIn(OauthReqDto data);
}
