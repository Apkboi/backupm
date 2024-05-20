import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/work_sheet/presentation/widgets/work_sheet_detail_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class WorksheetDetailScreen extends StatefulWidget {
  const WorksheetDetailScreen({super.key, required this.id});

  final String id;

  @override
  State<WorksheetDetailScreen> createState() => _WorksheetDetailScreenState();
}

class _WorksheetDetailScreenState extends State<WorksheetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> daysOfWeek = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    String selectedDay = "TUE";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallets.white,
        foregroundColor: Pallets.black,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
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
        title: const TextView(
          text: 'WorkSheet Name',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      daysOfWeek.length,
                      (index) => HapticInkWell(
                            onTap: () {
                              logger.i(daysOfWeek[index]);
                              setState(() {
                                selectedDay = daysOfWeek[index].toUpperCase();
                              });
                              logger.i(daysOfWeek[index]);
                            },
                            child: CircleAvatar(
                              backgroundColor: daysOfWeek[index] == selectedDay
                                  ? Pallets.primary
                                  : Colors.transparent,
                              radius: 22,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextView(
                                  text: daysOfWeek[index],
                                  fontSize: 13,
                                  color: daysOfWeek[index] == selectedDay
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
                  child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: WorkSheetDetailItem(),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
