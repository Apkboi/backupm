import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/work_sheet/data/models/get_all_work_sheet_response.dart';

class WorkSheetItem extends StatelessWidget {
  const WorkSheetItem({super.key, required this.workSheet});

  final WorkSheetModel workSheet;

  @override
  Widget build(BuildContext context) {
    return HapticInkWell(
      onTap: () {
        _goToWorkSheetScreen(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Pallets.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: workSheet.title,
              fontSize: 16,
              color: Pallets.primary,
              fontWeight: FontWeight.w600,
            ),
            4.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: TimeUtil.worSheetFormat(workSheet.createdAt.toString()),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                _WorkSheetStatus(
                  status: workSheet.status,
                ),
              ],
            ),
            16.verticalSpace,
            TextView(text: workSheet.description)
          ],
        ),
      ),
    );
  }

  void _goToWorkSheetScreen(BuildContext context) {
    if (workSheet.type == "weekly-task") {
      context.pushNamed(PageUrl.worksheetDetails, queryParameters: {
        PathParam.id: workSheet.id.toString(),
        PathParam.name: workSheet.title,
      });
    } else {
      context.pushNamed(PageUrl.questionaireScreen, queryParameters: {
        PathParam.id: workSheet.id.toString(),
        PathParam.name: workSheet.title,
      });
    }
  }
}

class _WorkSheetStatus extends StatelessWidget {
  const _WorkSheetStatus({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: getbColorByStatus(status),
          borderRadius: BorderRadius.circular(100)),
      child: TextView(
        text: status,
        fontWeight: FontWeight.w600,
        color: getColorByStatus(status),
      ),
    );
  }

  Color getColorByStatus(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Pallets.yelloDarker ;
      case "submitted":
        return Colors.green;
      case "completed":
        return Pallets.greenDarker;
      case "rejected":
        return Colors.red;
      default:
        // Handle unknown statuses gracefully
        print("WARNING: Unknown status: $status. Returning default color.");
        return Colors.grey; // Or another appropriate default color
    }
  }
  Color getbColorByStatus(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Color(0xFFFBDFB1);
      case "submitted":
        return Colors.green;
      case "completed":
        return const Color(0xFFCBF5E5);

      case "rejected":
        return Colors.red;
      default:
      // Handle unknown statuses gracefully
        print("WARNING: Unknown status: $status. Returning default color.");
        return Colors.grey; // Or another appropriate default color
    }
  }

}
