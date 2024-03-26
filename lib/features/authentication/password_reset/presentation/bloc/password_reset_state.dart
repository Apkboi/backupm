part of 'password_reset_bloc.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState();
}

class PasswordResetInitial extends PasswordResetState {
  @override
  List<Object> get props => [];
}

class PasswordResetOtpLoadingState extends PasswordResetState {
  @override
  List<Object?> get props => [];
}

class PasswordResetOtpSuccessState extends PasswordResetState {
  final dynamic response;

  const PasswordResetOtpSuccessState(this.response);

  @override
  List<Object?> get props => [dynamic];
}

class PasswordResetOtpFailureState extends PasswordResetState {
  final String error;

  const PasswordResetOtpFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class VerifyPasswordResetOtpLoadingState extends PasswordResetState {
  @override
  List<Object?> get props => [];
}

class VerifyPasswordResetOtpSuccessState extends PasswordResetState {
  final dynamic response;

  const VerifyPasswordResetOtpSuccessState(this.response);

  @override
  List<Object?> get props => [];
}

class VerifyPasswordResetOtpFailureState extends PasswordResetState {
  final String error;

  const VerifyPasswordResetOtpFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ResetPasswordLoadingState extends PasswordResetState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccessState extends PasswordResetState {
  final dynamic response;
  const ResetPasswordSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class ResetPasswordFailureState extends PasswordResetState {
  final String error;

  const ResetPasswordFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
