import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/database/local/userstorage.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  Future<void> close() async {}

  MentraUser? appUser;

  final _userStorage = UserStorage();

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {});

    on<SaveUserEvent>(_mapSaveUserEventToState);
    on<GetUserEvent>(_mapGetUserEventToState);
  }

  FutureOr<void> _mapSaveUserEventToState(
      SaveUserEvent event, Emitter<UserState> emit) {
    _userStorage.saveUser(event.appUser);
    appUser = event.appUser;
    emit(UserCachedState(event.appUser));
  }

  FutureOr<void> _mapGetUserEventToState(
      GetUserEvent event, Emitter<UserState> emit) async {
    var user = await _userStorage.getUser();

    if (user != null) {
      appUser = user;
      emit(UserCachedState(user));
    }
  }
}
