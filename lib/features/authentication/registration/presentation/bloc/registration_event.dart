part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegisterEvent extends RegistrationEvent {
  final RegistrationPayload payload;

  const RegisterEvent({required this.payload});

  @override
  List<Object?> get props => [payload];
}

class SendOtpEvent extends RegistrationEvent {
  final String email;

  const SendOtpEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyOtpEvent extends RegistrationEvent {
  final String email;
  final String otp;

  const VerifyOtpEvent({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}

class AppleAuthEvent extends RegistrationEvent {
  const AppleAuthEvent();

  @override
  List<Object?> get props => [];
}

class GoogleAuthEvent extends RegistrationEvent {
  const GoogleAuthEvent();

  @override
  List<Object?> get props => [];
}

