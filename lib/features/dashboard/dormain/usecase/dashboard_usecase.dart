import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';

class DashboardUsecase {
  Future<void> execute() async {
    injector.get<DashboardBloc>().add(GetConversationStarterEvent());
  }
}
