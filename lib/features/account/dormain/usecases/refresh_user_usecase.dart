import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';

class RefreshUserUsecase {
  Future<void> execute() async {
    injector.get<UserBloc>().add(GetRemoteUser());
  }
}
