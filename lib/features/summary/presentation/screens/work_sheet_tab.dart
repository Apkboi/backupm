import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';

class WorkSheetTab extends StatefulWidget {
  const WorkSheetTab({super.key});

  @override
  State<WorkSheetTab> createState() => _WorkSheetTabState();
}

class _WorkSheetTabState extends State<WorkSheetTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        100.verticalSpace,
        Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: const [
              AppEmptyState(
                tittle: 'Your Work Sheet Space Awaits',
                hasBg: false,
              ),
              // Spacer(),
            ],
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 5,
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 0,
        //     ),
        //     itemBuilder: (context, index) => const Padding(
        //       padding: EdgeInsets.symmetric(vertical: 8.0),
        //       child: SummaryItem(),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
