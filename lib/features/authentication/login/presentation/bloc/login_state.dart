part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  final AuthSuccessResponse response;

  const LoginSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class LoginFailureState extends LoginState {
  final String error;

  const LoginFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoginPreviewLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginPreviewSuccessState extends LoginState {
  final LoginPreviewResponse response;

  const LoginPreviewSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class LoginPreviewFailureState extends LoginState {
  final String error;

  const LoginPreviewFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
class OauthLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class  LoginOauthSuccessState extends LoginState {
  final OauthResponse response;

  LoginOauthSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class  OauthFailureState extends LoginState {
  final String error;

  const OauthFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
