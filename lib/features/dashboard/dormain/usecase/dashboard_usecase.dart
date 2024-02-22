import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';


class DashboardUsecase {
  Future<void> execute() async {
    injector.get<DashboardBloc>().add(GetConversationStarterEvent());

    // void _initMesibo() async {
    //   Mesibo mesibo = Mesibo();
    //   mesibo.setAccessToken(
    //       'd6582a9d25c85cbf4c9386e5d3529cdbb8f89d911dab801fae224ad1e4ga1499143eaf');
    //   await mesibo.stop();
    //   mesibo.setListener(MesiboCubit());
    //   mesibo.start().then((value) => logger.i('Started'));
    // }

    // Mesibo.getInstance().setAccessToken(
    //     'd6582a9d25c85cbf4c9386e5d3529cdbb8f89d911dab801fae224ad1e4ga1499143eaf');

    // injector.get<MesiboCubit>().initialize();
  }
}
