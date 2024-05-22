import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_tabbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/summary/presentation/screens/summary_tab.dart';
import 'package:mentra/features/work_sheet/presentation/screens/work_sheet_tab.dart';
import 'package:mentra/features/tasks/presentation/screens/daily_task_tab.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class MyActivitiesScreen extends StatefulWidget {
  const MyActivitiesScreen({Key? key, required this.tabIndex})
      : super(key: key);
  final int? tabIndex;

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (widget.tabIndex != null) {
          tabController.animateTo(widget.tabIndex ?? 0);
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        centerTile: false,
        // canGoBack: false,
        leading: 0.horizontalSpace,
        leadingWidth: 0,
        tittle: TextView(
          text: 'My Activities',
          style: GoogleFonts.fraunces(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Pallets.primaryDark),
        ),
        actions: [
          HapticInkWell(
            onTap: () {
              context.goNamed(PageUrl.menuScreen);
            },
            child: CircleAvatar(
              backgroundColor: Pallets.white,
              radius: 25,
              child: ImageWidget(imageUrl: Assets.images.svgs.menuIcon),
            ),
          ),
          16.horizontalSpace,
        ],
      ),
      body: Stack(
        children: [
          AppBg(image: Assets.images.pngs.homeBg.path),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                children: [
                  // 120.verticalSpace,
                  CustomTabbar(controller: tabController, tabs: const [
                    Tab(
                      text: "Daily Tasks",
                    ),
                    Tab(
                      text: "Summaries",
                    ),
                    Tab(text: "Worksheet"),
                  ]),
                  20.verticalSpace,
                  Expanded(
                      child: TabBarView(
                          controller: tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                        DailyTaskTab(),
                        SummaryTab(),
                        WorkSheetTab(),
                      ])),
                  8.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
