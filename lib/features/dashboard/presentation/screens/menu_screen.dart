import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/dashboard/presentation/widget/menu_item.dart';
import 'package:mentra/features/dashboard/presentation/widget/upcoming_session.dart';
import 'package:mentra/gen/assets.gen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomNeumorphicButton(
                expanded: false,
                onTap: () {
                  context.goNamed(PageUrl.homeScreen);
                },
                color: Pallets.primary,
                text: 'Home',
                padding: const EdgeInsets.symmetric(horizontal: 50),
              ),
            ],
          ),
        ),
      ),
      appBar: CustomAppBar(
        tittleText: '',
        leadingWidth: 75,
        actions: [
          CircleAvatar(
            backgroundColor: Pallets.white,
            child: ImageWidget(imageUrl: Assets.images.svgs.bell),
          ),
          10.horizontalSpace,
          CircleAvatar(
            backgroundColor: Pallets.white,
            child: ImageWidget(imageUrl: Assets.images.svgs.settings),
          ),
          16.horizontalSpace,
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomNeumorphicButton(
            onTap: () {},
            color: Pallets.primary,
            padding: EdgeInsets.zero,
            text: 'SOS',
          ),
        ),
      ),
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    const TextView(
                      text: 'Upcoming Session',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Pallets.primary,
                    ),
                    24.verticalSpace,
                    const UpcomingSession(),
                    48.verticalSpace,
                    const TextView(
                      text: 'Your Journey',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Pallets.primary,
                    ),
                    24.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: MenuItem(
                                textColor: Pallets.orangePink,
                                bgColor: Pallets.lighterPink,
                                onTap: () {
                                  context.pushNamed(PageUrl.therapyScreen);
                                },
                                image: Assets.images.pngs.pTherapy.path,
                                text: "Professional Therapy")),
                        16.horizontalSpace,
                        Expanded(
                            child: MenuItem(
                                textColor: Pallets.mildGreen,
                                bgColor: Pallets.lightGreen,
                                image: Assets.images.pngs.wLibrary.path,
                                text: "Wellness Library")),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: MenuItem(
                                textColor: Pallets.brown,
                                bgColor: Pallets.lightOrange,
                                image: Assets.images.pngs.summary.path,
                                text: "Summaries")),
                        16.horizontalSpace,
                        Expanded(
                            child: MenuItem(
                                textColor: Pallets.indigo,
                                bgColor: Pallets.lightBlue,
                                image: Assets.images.pngs.gJournal.path,
                                text: "Guided Journal")),
                      ],
                    ),
                    100.verticalSpace
                  ],
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child:,
          // )
        ],
      ),
    );
  }
}
