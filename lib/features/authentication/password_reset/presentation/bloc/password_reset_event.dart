part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();
}

class SendPasswordResetOtpEvent extends PasswordResetEvent {
  final String email;

  const SendPasswordResetOtpEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyPasswordResetOtpEvent extends PasswordResetEvent {
  final String email;
  final String otp;

  const VerifyPasswordResetOtpEvent({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}

class ResetPasswordEvent extends PasswordResetEvent {
  final String code;
  final String password;

  const ResetPasswordEvent({required this.code, required this.password});

  @override
  List<Object?> get props => [code, password];
}
