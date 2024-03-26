import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/database/local/userstorage.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/account/dormain/repository/account_repository.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AccountRepository _accountRepository;

  @override
  Future<void> close() async {}

  MentraUser? appUser;

  final _userStorage = UserStorage();

  UserBloc(this._accountRepository) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});

    on<SaveUserEvent>(_mapSaveUserEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
    on<GetRemoteUser>(_mapGetRemoteUserToState);
  }

  FutureOr<void> _mapSaveUserEventToState(
      SaveUserEvent event, Emitter<UserState> emit) async {
    _userStorage.saveUser(event.appUser);
    appUser = event.appUser;
    // injector.get<MesiboCubit>().initialize();
    emit(UserCachedState(event.appUser));
  }

  FutureOr<void> _mapGetUserEventToState(
      GetUserEvent event, Emitter<UserState> emit) async {
    var user = await _userStorage.getUser();

    if (user != null) {
      appUser = user;

      logger.i(appUser?.toJson());

      // injector.get<MesiboCubit>().initialize();
      emit(UserCachedState(user));
    }
  }

  FutureOr<void> _mapGetRemoteUserToState(
      GetRemoteUser event, Emitter<UserState> emit) async {
    try {
      final response = await _accountRepository.getRemoteUser();

      add(SaveUserEvent(response.data));
    } catch (e) {
      // emit(LoginFailureState(error: e.toString()));
    }
  }
}
