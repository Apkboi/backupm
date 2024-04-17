part of 'local_auth_cubit.dart';

abstract class LocalAuthState extends Equatable {
  const LocalAuthState();
}

class LocalAuthInitial extends LocalAuthState {
  @override
  List<Object> get props => [];
}

class PinCorrectState extends LocalAuthState {
  final dynamic response;

  const PinCorrectState(this.response);

  @override
  List<Object?> get props => [];
}

class PinUpdatedState extends LocalAuthState {
  final String pin;

  const PinUpdatedState(this.pin);

  @override
  List<Object?> get props => [];
}

class UpdatePinLoadingState extends LocalAuthState {
  const UpdatePinLoadingState();

  @override
  List<Object?> get props => [];
}

class UpdatePinFailedState extends LocalAuthState {
  final String pin;

  const UpdatePinFailedState(this.pin);

  @override
  List<Object?> get props => [];
}

class PinIncorrectState extends LocalAuthState {
  final String incorrectPin;

  const PinIncorrectState(this.incorrectPin);

  @override
  List<Object?> get props => [incorrectPin];

  @override
  bool operator ==(Object object) => false;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

class BiometricEnabledState extends LocalAuthState {
  const BiometricEnabledState();

  @override
  List<Object?> get props => [];
}

class BiometricDisabledState extends LocalAuthState {
  const BiometricDisabledState();

  @override
  List<Object?> get props => [];
}

class BiometricEnableFailedState extends LocalAuthState {
  final String error;

  const BiometricEnableFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

class PinValidatingState extends LocalAuthState {
  const PinValidatingState();

  @override
  List<Object?> get props => [];
}
