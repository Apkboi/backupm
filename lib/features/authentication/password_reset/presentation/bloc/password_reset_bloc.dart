import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/authentication/password_reset/dormain/repository/password_reset_repository.dart';

part 'password_reset_event.dart';

part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final PasswordResetRepository _passwordResetRepository;

  PasswordResetBloc(this._passwordResetRepository)
      : super(PasswordResetInitial()) {
    on<PasswordResetEvent>((event, emit) {});
    on<SendPasswordResetOtpEvent>(_mapSendPasswordResetOtpEventToState);
    on<VerifyPasswordResetOtpEvent>(_mapVerifyPasswordResetOtpEvent);
    on<ResetPasswordEvent>(_mapResetPasswordEventToState);
  }

  FutureOr<void> _mapSendPasswordResetOtpEventToState(
      SendPasswordResetOtpEvent event, Emitter<PasswordResetState> emit) async {
    try {
      emit(PasswordResetOtpLoadingState());
      var response = await _passwordResetRepository.forgotPassword(event.email);
      emit(PasswordResetOtpSuccessState(response));
    } catch (e) {
      emit(PasswordResetOtpFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapVerifyPasswordResetOtpEvent(
      VerifyPasswordResetOtpEvent event,
      Emitter<PasswordResetState> emit) async {
    try {
      emit(VerifyPasswordResetOtpLoadingState());
      var response =
          await _passwordResetRepository.verifyOtp(event.otp, event.email);
      emit(VerifyPasswordResetOtpSuccessState(response));
    } catch (e) {
      emit(VerifyPasswordResetOtpFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapResetPasswordEventToState(
      ResetPasswordEvent event, Emitter<PasswordResetState> emit) async {
    try {
      emit(ResetPasswordLoadingState());
      var response = await _passwordResetRepository.resetPassword(
          event.password, event.hashKey);
      emit(ResetPasswordSuccessState(response));
    } catch (e) {
      emit(ResetPasswordFailureState(error: e.toString()));
    }
  }
}
