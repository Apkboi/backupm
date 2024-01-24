import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/custom_tabbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_date_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_time_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class TherapyScreen extends StatefulWidget {
  const TherapyScreen({Key? key}) : super(key: key);

  @override
  State<TherapyScreen> createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
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
          text: 'Therapy',
          style:
              GoogleFonts.fraunces(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
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
          const AppBg(),
          DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  100.verticalSpace,
                  const CustomTabbar(tabs: [
                    Tab(
                      text: "Upcoming",
                    ),
                    Tab(text: "History"),
                  ]),
                  const Expanded(
                      child: TabBarView(
                          physics: BouncingScrollPhysics(),
                          children: [UpcomingTherapy(), TherapyHistory()])),
                  8.verticalSpace,
                  CustomNeumorphicButton(
                    onTap: () {
                      CustomDialogs.showCupertinoBottomSheet(context,
                          SelectDateSheet(
                        onSelected: (DateTime onSelected) {
                          CustomDialogs.showCupertinoBottomSheet(
                              context, const SelectTimeSheet());
                        },
                      ));
                    },
                    fgColor: Pallets.white,
                    color: Pallets.primary,
                    text: "Schedule Session",
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Pallets.white,
                          size: 18,
                        ),
                        TextView(
                          text: 'Schedule Session',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Pallets.white),
                        )
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  CustomOutlinedButton(
                    bgColor: Colors.white,
                    padding: const EdgeInsets.all(20),
                    outlineWidth: 1.5,
                    radius: 100,
                    outlinedColr: Pallets.primary,
                    child: const TextView(
                      text: 'Change Therapist',
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      context.pushNamed(PageUrl.therapistProfile);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingTherapy extends StatefulWidget {
  const UpcomingTherapy({super.key});

  @override
  State<UpcomingTherapy> createState() => _UpcomingTherapyState();
}

class _UpcomingTherapyState extends State<UpcomingTherapy> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      itemBuilder: (context, index) => const TherapyItem(),
    );
  }
}

class TherapyHistory extends StatefulWidget {
  const TherapyHistory({super.key});

  @override
  State<TherapyHistory> createState() => _TherapyHistoryState();
}

class _TherapyHistoryState extends State<TherapyHistory> {
  @override
  Widget build(BuildContext context) {
    // return const Column(children: [
    //
    //   TherapyEmptyState()]);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => const TherapyItem(),
    );
  }
}
