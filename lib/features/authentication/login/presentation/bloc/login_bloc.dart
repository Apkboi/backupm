import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/authentication/data/models/login_preview_response.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';
import 'package:mentra/features/authentication/dormain/usecase/auth_success_usecase.dart';
import 'package:mentra/features/dashboard/dormain/usecase/dashboard_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _userRepository;

  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<LoginUserEvent>(_mapLoginEventToState);
    on<LoginPreviewEvent>(_mapLoginPreviewEventToState);
  }

  UserPreview? userPreview;

  Future<void> _mapLoginEventToState(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      final authResponse = await _userRepository.login(event.email, event.password);

      // Assuming loginUser returns the user details upon successful login
      AuthSuccessUsecase().execute(authResponse);

      emit(LoginSuccessState(response: authResponse));
    } catch (e) {
      emit(LoginFailureState(error: e.toString()));
    }
  }

  Future<void> _mapLoginPreviewEventToState(
      LoginPreviewEvent event, Emitter<LoginState> emit) async {
    emit(LoginPreviewLoadingState());

    try {
      final loginPreviewResponse =
          await _userRepository.loginPreview(event.email);

      userPreview = loginPreviewResponse.data;

      emit(LoginPreviewSuccessState(response: loginPreviewResponse));
    } catch (e) {
      emit(LoginPreviewFailureState(error: e.toString()));
    }
  }
}
