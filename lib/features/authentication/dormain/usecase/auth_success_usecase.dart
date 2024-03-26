import 'package:mentra/common/database/local/userstorage.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';

class AuthSuccessUsecase {
  final _userStorage = UserStorage();

  Future<void> execute(AuthSuccessResponse response) async {
    SessionManager.instance.isLoggedIn = true;
    _userStorage.saveUserToken(response.data.token);
    _userStorage.saveUser(response.data.user);
    injector.get<UserBloc>().add(SaveUserEvent(response.data.user));
    logger.i("USER DETAILS SAVED");
  }
}
