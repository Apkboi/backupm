import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/services/firebase/notifiactions.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/authentication/data/models/oauth_req_dto.dart';
import 'package:mentra/features/authentication/data/models/onauth_response.dart';
import 'package:mentra/features/authentication/data/models/register_payload.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';
import 'package:mentra/features/authentication/dormain/usecase/auth_success_usecase.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;
  RegistrationPayload registrationPayload = RegistrationPayload.empty();
  String initialPasscode = '';

  RegistrationBloc(this._authRepository) : super(RegistrationInitial()) {
    on<RegisterEvent>(_mapRegisterEventToState);
    on<SendOtpEvent>(_mapSendOtpEventToState);
    on<VerifyOtpEvent>(_mapVerifyOtpEventToState);
    on<GoogleAuthEvent>(_mapGoogleAuthEventToState);
    on<AppleAuthEvent>(_mapAppleAuthEventToState);
    on<SignupCompleteEvent>(_mapSignupCompleteEventToState);
  }

  Future<void> _mapRegisterEventToState(
      RegisterEvent event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoadingState());

    try {
      // Call your registration API here
      var authResponse = await _authRepository.register(
          event.payload.copyWith(token: notiToken, apnToken: voipToken));

      AuthSuccessUsecase()
          .execute(authResponse, passKey: event.payload.password);

      emit(RegistrationSuccessState(authResponse));
    } catch (e) {
      emit(RegistrationFailureState(error: e.toString()));
    }
  }

  Future<void> _mapSendOtpEventToState(
      SendOtpEvent event, Emitter<RegistrationState> emit) async {
    emit(SendOtpLoadingState());

    try {
      // Call your send OTP API here
      await _authRepository.sendOtp(event.email);

      emit(SendOtpSuccessState());
    } catch (e) {
      emit(SendOtpFailureState(error: e.toString()));
    }
  }

  Future<void> _mapVerifyOtpEventToState(
      VerifyOtpEvent event, Emitter<RegistrationState> emit) async {
    emit(VerifyOtpLoadingState());

    try {
      // Call your verify OTP API here
      final isVerified =
          await _authRepository.verifyOtp(event.email, event.otp);

      emit(VerifyOtpSuccessState());
    } catch (e) {
      emit(VerifyOtpFailureState(error: e.toString()));
    }
  }

  void updateFields({
    String? name,
    String? email,
    String? birthYear,
    String? password,
    String? avatarPath,
    String? role,
    String? token,
    String? apnToken,
  }) {
    registrationPayload = RegistrationPayload(
      name: name ?? registrationPayload.name,
      email: email ?? registrationPayload.email,
      birthYear: birthYear ?? registrationPayload.birthYear,
      password: password ?? registrationPayload.password,
      avatar: avatarPath ?? registrationPayload.avatar,
      role: role ?? registrationPayload.role,
      token: token ?? registrationPayload.token,
      apnToken: apnToken ?? registrationPayload.apnToken,
    );
  }

  // Function to check if any of the fields are null
  bool anyFieldIsNull() {
    return registrationPayload.name.isEmpty ||
        registrationPayload.email.isEmpty ||
        registrationPayload.birthYear.isEmpty ||
        registrationPayload.password.isEmpty ||
        registrationPayload.avatar.isEmpty ||
        registrationPayload.role.isEmpty;
  }

  void clear() {
    registrationPayload = RegistrationPayload.empty();
  }

  FutureOr<void> _mapGoogleAuthEventToState(
      GoogleAuthEvent event, Emitter<RegistrationState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.googleAuth();
      if (response?.idToken == null) {
        emit(const OauthFailureState(error: "Google auth failed"));
        return;
      }
      var res = await _authRepository.oauthSignIn(OauthReqDto(
        token: response?.idToken,
        provider: 'google',
      ));
      if (!res.data.newUser) {
        AuthSuccessUsecase().execute(res.toAuthSuccessResponse);
      }
      emit(OauthSuccessState(res));
    } catch (e) {
      emit(OauthFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapAppleAuthEventToState(
      AppleAuthEvent event, Emitter<RegistrationState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.appleAuth();
      var res = await _authRepository.oauthSignIn(OauthReqDto(
        token: response?.identityToken,
        provider: 'apple',
      ));

      if (!res.data.newUser) {
        AuthSuccessUsecase().execute(res.toAuthSuccessResponse);
      }
      emit(OauthSuccessState(res));
    } catch (e) {
      emit(OauthFailureState(error: e.toString()));
    }
  }

  bool confirmPasscode(String passcode) => initialPasscode == passcode;

  FutureOr<void> _mapSignupCompleteEventToState(
      SignupCompleteEvent event, Emitter<RegistrationState> emit) {
    emit(const SignupCompleteState());
  }
}
