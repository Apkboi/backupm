import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/daily_streak/daily_streak_checker.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';

class RefreshUserUsecase {
  Future<void> execute() async {
    injector.get<UserBloc>().add(GetRemoteUser());
  }
}
