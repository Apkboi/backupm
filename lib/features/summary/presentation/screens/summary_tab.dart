import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/summary/presentation/widgets/summary_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';

class SummaryTab extends StatefulWidget {
  const SummaryTab({super.key});

  @override
  State<SummaryTab> createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
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
                tittle: 'Your Summaries Space Awaits',
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
