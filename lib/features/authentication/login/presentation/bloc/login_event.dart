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

class LoginPreviewEvent extends LoginEvent {
  final String email;

  const LoginPreviewEvent({required this.email});

  @override
  List<Object?> get props => [email];
}