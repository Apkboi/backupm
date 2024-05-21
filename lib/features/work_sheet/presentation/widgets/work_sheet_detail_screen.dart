import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/models/day_of_week.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/work_sheet/presentation/blocs/worksheet/worksheet_bloc.dart';
import 'package:mentra/features/work_sheet/presentation/widgets/work_sheet_detail_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class WorksheetDetailScreen extends StatefulWidget {
  const WorksheetDetailScreen(
      {super.key, required this.id, required this.name});

  final String id;
  final String name;

  @override
  State<WorksheetDetailScreen> createState() => _WorksheetDetailScreenState();
}

class _WorksheetDetailScreenState extends State<WorksheetDetailScreen> {
  // String selectedDay = "MONDAY";

  final _bloc = WorkSheetBloc(injector.get());

  @override
  void initState() {
    _bloc.add(GetWorkSheetDetailsEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<DayOfWeek> weekdays = weekdaysd;

    return BlocProvider(
      create: (_) => _bloc,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Pallets.white,
            foregroundColor: Pallets.black,
            elevation: 0,
            centerTitle: true,
            leading: HapticInkWell(
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ImageWidget(
                  imageUrl: Assets.images.svgs.arrowLeft,
                  size: 16,
                  height: 25,
                  width: 25,
                  onTap: () {
                    context.pop();
                  },
                ),
              ),
            ),
            title: TextView(
              text: widget.name,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: Stack(
            children: [
              const AppBg(),
              Column(
                children: [
                  Container(
                    color: Pallets.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          weekdays.length,
                          (index) => HapticInkWell(
                                onTap: () {
                                  setState(() {
                                    context.read<WorkSheetBloc>().add(
                                        SortWorkSheetByDay(weekdays[index]));
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: isSelectedDay(context, index)
                                      ? Pallets.primary
                                      : Colors.transparent,
                                  radius: 22,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: TextView(
                                      text: weekdays[index].abbreviation,
                                      fontSize: 13,
                                      color: isSelectedDay(context, index)
                                          ? Pallets.white
                                          : Pallets.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  Expanded(
                      child: BlocConsumer<WorkSheetBloc, WorkSheetState>(
                    bloc: _bloc,
                    listener: _listenToWorkSheetBloc,
                    builder: (context, state) {
                      var stagedTasks =
                          context.watch<WorkSheetBloc>().stagedTasks;
                      if (state is GetWorksheetDetailsLoadingState) {
                        return Center(
                          child: CustomDialogs.getLoading(size: 30),
                        );
                      }

                      if (state is GetWorksheetDetailsFailureState) {
                        return AppPromptWidget(
                          title: state.error,
                          onTap: () {
                            _bloc.add(GetWorkSheetDetailsEvent(widget.id));
                          },
                        );
                      }

                      return ListView(
                        children: [

                          WorkSheetDetailItem(
                            weeklyTask: stagedTasks.firstOrNull?.tasks
                                    .where(
                                        (element) => element.time == "morning")
                                    .toList() ??
                                [],
                            period: 'Morning',
                          ),
                          WorkSheetDetailItem(
                            weeklyTask: stagedTasks.firstOrNull?.tasks
                                    .where(
                                        (element) => element.time == "afternoon")
                                    .toList() ??
                                [],
                            period: 'Afternoon',
                          ),
                          WorkSheetDetailItem(
                            weeklyTask: stagedTasks.firstOrNull?.tasks
                                    .where(
                                        (element) => element.time == "evening")
                                    .toList() ??
                                [],
                            period: 'Evening',
                          ),
                        ],
                      );

                    },
                  ))
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  bool isSelectedDay(BuildContext context, int index) {
    return context.watch<WorkSheetBloc>().selectedDay.fullDay.toUpperCase() ==
        weekdays[index].fullDay.toUpperCase();
  }

  void _listenToWorkSheetBloc(BuildContext context, WorkSheetState state) {}
}
