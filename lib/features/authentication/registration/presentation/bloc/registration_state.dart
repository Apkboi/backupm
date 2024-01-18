part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationLoadingState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationSuccessState extends RegistrationState {
  final AuthSuccessResponse authSuccessResponse;

  @override
  List<Object?> get props => [authSuccessResponse];

  RegistrationSuccessState(this.authSuccessResponse);
}

class RegistrationFailureState extends RegistrationState {
  final String error;

  const RegistrationFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class SendOtpLoadingState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class SendOtpSuccessState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class SendOtpFailureState extends RegistrationState {
  final String error;

  const SendOtpFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class VerifyOtpLoadingState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class VerifyOtpSuccessState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class VerifyOtpFailureState extends RegistrationState {
  final String error;

  const VerifyOtpFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}