import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/firebase/notifiactions.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/authentication/data/models/login_preview_response.dart';
import 'package:mentra/features/authentication/data/models/oauth_req_dto.dart';
import 'package:mentra/features/authentication/data/models/onauth_response.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';
import 'package:mentra/features/authentication/dormain/usecase/auth_success_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginUserEvent>(_mapLoginEventToState);
    on<LoginPreviewEvent>(_mapLoginPreviewEventToState);
    on<GoogleAuthEvent>(_mapGoogleAuthEventToState);
    on<AppleAuthEvent>(_mapAppleAuthEventToState);
  }

  UserPreview? userPreview;

  Future<void> _mapLoginEventToState(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      final authResponse =
          await _authRepository.login(event.email, event.password);

      // Assuming loginUser returns the user details upon successful login
      AuthSuccessUsecase().execute(authResponse, passKey: event.password);

      emit(LoginSuccessState(response: authResponse));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(LoginFailureState(error: e.toString()));
    }
  }

  Future<void> _mapLoginPreviewEventToState(
      LoginPreviewEvent event, Emitter<LoginState> emit) async {
    emit(LoginPreviewLoadingState());

    try {
      final loginPreviewResponse =
          await _authRepository.loginPreview(event.email);

      userPreview = loginPreviewResponse.data;

      emit(LoginPreviewSuccessState(response: loginPreviewResponse));
    } catch (e) {
      emit(LoginPreviewFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapGoogleAuthEventToState(
      GoogleAuthEvent event, Emitter<LoginState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.googleAuth();
      if (response?.accessToken == null) {
        throw 'Couldn\'t complete google authentication';
      }
      var res = await _authRepository.oauthSignIn(OauthReqDto(
          token: response?.idToken, provider: 'google', fcmToken: notiToken,apnToken: voipToken));
      if (!res.data.newUser) {
        AuthSuccessUsecase().execute(
          res.toAuthSuccessResponse,
        );
      }
      emit(LoginOauthSuccessState(res));
    } catch (e) {
      emit(OauthFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapAppleAuthEventToState(
      AppleAuthEvent event, Emitter<LoginState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.appleAuth();
      if (response?.identityToken == null) {
        throw 'Couldn\'t complete apple authentication';
      }
      var res = await _authRepository.oauthSignIn(OauthReqDto(
          token: response?.identityToken,
          provider: 'apple',
          apnToken: voipToken,
          fcmToken: notiToken));
      if (!res.data.newUser) {
        AuthSuccessUsecase().execute(res.toAuthSuccessResponse);
      }

      emit(LoginOauthSuccessState(res));
    } catch (e) {
      emit(OauthFailureState(error: e.toString()));
    }
  }
}
