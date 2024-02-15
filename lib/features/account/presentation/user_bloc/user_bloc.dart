import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/database/local/userstorage.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/mesibo/presentation/bloc/mesibo_cubit.dart';

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
      SaveUserEvent event, Emitter<UserState> emit) async {
    _userStorage.saveUser(event.appUser);
    appUser = event.appUser;
    // await injector.get<MesiboCubit>().initialize();
    emit(UserCachedState(event.appUser));
  }

  FutureOr<void> _mapGetUserEventToState(
      GetUserEvent event, Emitter<UserState> emit) async {
    var user = await _userStorage.getUser();

    if (user != null) {
      appUser = user;
      // await injector.get<MesiboCubit>().initialize();
      emit(UserCachedState(user));
    }
  }
}
