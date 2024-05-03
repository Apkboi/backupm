import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/utils/extensions/date_extensions.dart';
import 'package:mentra/features/tasks/presentation/widget/home_tasks_widget.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/widgets/upcoming_session_widget.dart';

class HomeUpcomingSessionWidget extends StatefulWidget {
  const HomeUpcomingSessionWidget({super.key});

  @override
  State<HomeUpcomingSessionWidget> createState() =>
      _HomeUpcomingSessionWidgetState();
}

class _HomeUpcomingSessionWidgetState extends State<HomeUpcomingSessionWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapyBloc, TherapyState>(
      bloc: injector.get<TherapyBloc>(),
      builder: (context, state) {
        return Builder(
          builder: (context) {
            if (injector
                .get<TherapyBloc>()
                .upComingSessions
                .where((element) => element.startsAt.isToday)
                .isNotEmpty) {
              return UpcomingSessionsWidget(
                session: injector
                    .get<TherapyBloc>()
                    .upComingSessions
                    .where((element) => element.startsAt.isToday)
                    .first,
              );
            }

            return const HomeTasksWidget();
          },
        );
      },
    );
  }
}
