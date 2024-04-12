import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mentra/features/tasks/presentation/bloc/daily_task_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';

class DashboardUsecase {
  Future<void> execute() async {
    injector.get<DashboardBloc>().add(GetConversationStarterEvent());
    injector.get<NotificationsBloc>().add(GetNotificationsEvent());
    injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());
    injector.get<TherapyBloc>().add(GetSessionHistoryEvent());
    injector.get<JournalBloc>().add(GetJournalsEvent());
    injector.get<JournalBloc>().add(GetPromptsEvent());
    injector.get<WellnessLibraryBloc>().add(GetLibraryCategoriesEvent());
    injector.get<DailyTaskBloc>().add(GetDailyTaskEvent());

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
