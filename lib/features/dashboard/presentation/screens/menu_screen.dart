import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/dashboard/presentation/widget/menu_item.dart';
import 'package:mentra/features/dashboard/presentation/widget/new_user_prompt.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/session_ended_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/subscription_prompt_dialog.dart';
import 'package:mentra/gen/assets.gen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.goNamed(PageUrl.homeScreen);
        logger.i('popping');

        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: CustomNeumorphicButton(
        //     expanded: false,
        //     onTap: () {
        //       context.goNamed(PageUrl.homeScreen);
        //     },
        //     color: Pallets.primary,
        //     text: 'Home',
        //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        //   ),
        // ),
        appBar: CustomAppBar(
          tittleText: '',
          leadingWidth: 80,
          height: 80,
          actions: [
            CircleAvatar(
              backgroundColor: Pallets.white,
              child: ImageWidget(imageUrl: Assets.images.svgs.bell),
            ),
            10.horizontalSpace,
            InkWell(
              onTap: () {
                context.pushNamed(PageUrl.settingsScreen);
              },
              child: CircleAvatar(
                backgroundColor: Pallets.white,
                child: ImageWidget(imageUrl: Assets.images.svgs.settings),
              ),
            ),
            16.horizontalSpace,
          ],
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomNeumorphicButton(
              onTap: () {
                context.pushNamed(PageUrl.emergencySosScreen);
              },
              color: Pallets.primary,
              padding: EdgeInsets.zero,
              text: 'SOS',
            ),
          ),
        ),
        body: Stack(
          children: [
            AppBg(
              image: Assets.images.pngs.homeBg.path,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      // const TextView(
                      //   text: 'Upcoming Session',
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.w600,
                      //   color: Pallets.primary,
                      // ),
                      // 24.verticalSpace,
                      // const UpcomingSession(),
                      // const UnlockPremiumWidget(),
                      const NewUserPrompt(),
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
                                  onTap: () async {
                                    _checkSubscription(context);
                                  },
                                  image: Assets.images.pngs.pTherapy.path,
                                  text: "Professional Therapy")),
                          16.horizontalSpace,
                          Expanded(
                              child: MenuItem(
                                  onTap: () {
                                    context.pushNamed(
                                        PageUrl.wellnessLibraryScreen);
                                  },
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
                                  onTap: () {
                                    context.pushNamed(PageUrl.summariesScreen);
                                  },
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
      ),
    );
  }

  bool _userISubscribed() {
    return injector.get<UserBloc>().appUser?.activeSubscription != null;
  }

  void _checkSubscription(BuildContext context) async {
    if (_userISubscribed()) {
      context.pushNamed(PageUrl.therapyScreen);
    } else {
      final bool? subscribe = await CustomDialogs.showBottomSheet(
          context, const SubscriptionPromptDialog(),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          constraints: BoxConstraints(maxHeight: 0.9.sh));
      if (subscribe ?? false) {
        context.pushNamed(PageUrl.selectPlanScreen);
      }
    }
  }
}
