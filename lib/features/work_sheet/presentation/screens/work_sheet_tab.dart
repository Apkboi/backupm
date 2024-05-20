import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/features/work_sheet/presentation/blocs/worksheet/worksheet_bloc.dart';
import 'package:mentra/features/work_sheet/presentation/blocs/worksheet/worksheet_bloc.dart';
import 'package:mentra/features/work_sheet/presentation/widgets/work_sheet_item.dart';

class WorkSheetTab extends StatefulWidget {
  const WorkSheetTab({super.key});

  @override
  State<WorkSheetTab> createState() => _WorkSheetTabState();
}

class _WorkSheetTabState extends State<WorkSheetTab> {
  final bloc = WorkSheetBloc(injector.get());

  @override
  void initState() {
    bloc.add(const GetWorkSheetsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<WorkSheetBloc, WorkSheetState>(
            bloc: bloc,
            listener: _listenToWorkSheetBloc,
            builder: (context, state) {
              if (state is WorkSheetLoadingState) {
                return Center(
                  child: CustomDialogs.getLoading(size: 30),
                );
              }

              if (state is WorkSheetFailureState) {
                return AppPromptWidget(
                  onTap: () {},
                );
              }

              if (state is GetWorkSheetsSuccessState) {
                if (state.response.data.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.response.data.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: WorkSheetItem(
                        workSheet: state.response.data[index],
                      ),
                    ),
                  );
                }

                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: const [
                      AppEmptyState(
                        tittle: 'No Worksheet',
                        hasBg: false,
                        subtittle: '',
                      ),
                      // Spacer(),
                    ],
                  ),
                );
              }

              return 0.verticalSpace;
            },
          ),
        )
      ],
    );
  }

  void _listenToWorkSheetBloc(BuildContext context, WorkSheetState state) {}
}
