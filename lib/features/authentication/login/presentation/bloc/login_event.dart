part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginUserEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class GoogleAuthEvent extends LoginEvent {
  const GoogleAuthEvent();

  @override
  List<Object?> get props => [];
}

class AppleAuthEvent extends LoginEvent {
  const AppleAuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginPreviewEvent extends LoginEvent {
  final String email;

  const LoginPreviewEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
