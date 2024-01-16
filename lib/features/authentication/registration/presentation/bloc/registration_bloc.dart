import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/authentication/data/models/register_payload.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';
import 'package:mentra/features/authentication/dormain/usecase/auth_success_usecase.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _userRepository;
  RegistrationPayload registrationPayload = RegistrationPayload.empty();

  RegistrationBloc(this._userRepository) : super(RegistrationInitial()) {
    on<RegisterEvent>(_mapRegisterEventToState);
    on<SendOtpEvent>(_mapSendOtpEventToState);
    on<VerifyOtpEvent>(_mapVerifyOtpEventToState);
  }

  Future<void> _mapRegisterEventToState(
      RegisterEvent event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoadingState());

    try {
      // Call your registration API here
      var authResponse = await _userRepository.register(event.payload);

      AuthSuccessUsecase().execute(authResponse);

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
      await _userRepository.sendOtp(event.email);

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
          await _userRepository.verifyOtp(event.email, event.otp);

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
  }) {
    registrationPayload = RegistrationPayload(
      name: name ?? registrationPayload.name,
      email: email ?? registrationPayload.email,
      birthYear: birthYear ?? registrationPayload.birthYear,
      password: password ?? registrationPayload.password,
      avatar: avatarPath ?? registrationPayload.avatar,
      role: role ?? registrationPayload.role,
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
}
