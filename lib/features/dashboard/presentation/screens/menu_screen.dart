import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/dormain/usecases/refresh_user_usecase.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/dashboard/presentation/widget/menu_item.dart';
import 'package:mentra/features/dashboard/presentation/widget/new_user_prompt.dart';
import 'package:mentra/gen/assets.gen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    RefreshUserUsecase().execute();
    super.initState();
  }

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
          // leadingWidth: 80,
          // height: 65,
          onBackPressed: () {
            context.pushNamed(PageUrl.homeScreen,
                queryParameters: {PathParam.startConvo: 'false'});
          },
          actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomNeumorphicButton(
                expanded: false,
                onTap: () {
                  context.pushNamed(PageUrl.emergencySosScreen);
                },
                color: Pallets.primary,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                text: 'SOS',
              ),
            ),
            16.horizontalSpace,
            InkWell(
              onTap: () {
                context.pushNamed(PageUrl.notificationsScreen);
              },
              child: CircleAvatar(
                backgroundColor: Pallets.white,
                child: ImageWidget(
                    onTap: () {
                      context.pushNamed(PageUrl.notificationsScreen);
                    },
                    imageUrl: Assets.images.svgs.bell),
              ),
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
        ),
        body: Stack(
          children: [
            AppBg(
              image: Assets.images.pngs.homeBg.path,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      10.verticalSpace,
                      const TextView(
                        text: 'Your Journey',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Pallets.primary,
                      ),
                      10.verticalSpace,
                      AnimationLimiter(
                        child: SizedBox(
                          child: Column(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 600),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset: 40.0,
                                delay: const Duration(milliseconds: 100),
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: MenuItem(
                                      textColor: Pallets.orangePink,
                                      bgColor: Pallets.lighterPink,
                                      image: Assets.images.pngs.summary.path,
                                      text: "My Activities",
                                      onTap: () {
                                        context
                                            .pushNamed(PageUrl.summariesScreen);
                                      },
                                      // image: Assets.images.pngs.pTherapy.path,
                                      // text: "Professional Therapy"
                                    )),
                                    16.horizontalSpace,
                                    Expanded(
                                        child: MenuItem(
                                      textColor: Pallets.brown,
                                      bgColor: Pallets.lightOrange,
                                      image: Assets.images.pngs.gJournal.path,
                                      text: "Guided Journal",

                                      onTap: () {
                                        context.pushNamed(
                                            PageUrl.guidedJournalScreen);
                                      },

                                      // image: Assets.images.pngs.summary.path,
                                      // text: "Summaries"
                                    )),
                                  ],
                                ),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: MenuItem(
                                            onTap: () {
                                              context.pushNamed(PageUrl
                                                  .wellnessLibraryScreen);
                                            },
                                            textColor: Pallets.mildGreen,
                                            bgColor: Pallets.lightGreen,
                                            image: Assets
                                                .images.pngs.wLibrary.path,
                                            text: "Wellness Library")),
                                    16.horizontalSpace,
                                    Expanded(
                                        child: MenuItem(
                                      textColor: Pallets.indigo,
                                      bgColor: Pallets.lightBlue,
                                      image: Assets.images.pngs.pTherapy.path,
                                      text: "Professional Support",
                                      onTap: () async {
                                        _checkSubscription(context);
                                      },
                                      // image: Assets.images.pngs.gJournal.path,
                                      // text: "Guided Journal"
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
      context.pushNamed(PageUrl.selectPlanScreen);

      // final bool? subscribe = await CustomDialogs.showBottomSheet(
      //     context, const SubscriptionPromptDialog(),
      //     shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(16),
      //       topRight: Radius.circular(16),
      //     )),
      //     constraints: BoxConstraints(maxHeight: 0.9.sh));
      // if (subscribe ?? false) {
      //   context.pushNamed(PageUrl.selectPlanScreen);
      // }
    }
  }
}
