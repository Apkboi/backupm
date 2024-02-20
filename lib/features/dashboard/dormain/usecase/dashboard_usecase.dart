import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/mesibo/mesibo_service.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/mesibo/presentation/bloc/mesibo_cubit.dart';

class DashboardUsecase {
  Future<void> execute() async {
    injector.get<DashboardBloc>().add(GetConversationStarterEvent());
    // MesiboService service = MesiboService();
    // await service.login(
    //     token:
    //         "68a28b89c8000016ebbd246fc64ccdd92444cf4557d0e444ac8d2iabc21eeb520",
    //     listener: injector.get<MesiboCubit>(),
    //     appName: "Mentra");
  }
}
