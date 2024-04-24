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
import 'package:mentra/features/summary/presentation/screens/work_sheet_tab.dart';
import 'package:mentra/features/tasks/presentation/screens/daily_task_tab.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';


class MyActivitiesScreen extends StatefulWidget {
  const MyActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen> {
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
            child: DefaultTabController(
              length: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Column(
                  children: [
                    // 120.verticalSpace,
                    const CustomTabbar(tabs: [
                      Tab(
                        text: "Daily Tasks",
                      ),
                      Tab(
                        text: "Summaries",
                      ),
                      Tab(text: "Worksheet"),
                    ]),
                    20.verticalSpace,
                    const Expanded(
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                          DailyTaskTab(),
                          SummaryTab(),
                          WorkSheetTab()
                        ])),
                    8.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
