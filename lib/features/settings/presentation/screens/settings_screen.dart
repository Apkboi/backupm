import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/dormain/usecases/refresh_user_usecase.dart';
import 'package:mentra/features/account/presentation/profile_image_widget.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_group_1.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_group_3.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_group_2.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void didChangeDependencies() {
    RefreshUserUsecase().execute();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    RefreshUserUsecase().execute();
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
          text: 'Settings',
          style: GoogleFonts.fraunces(
              fontSize: 32.sp,
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
              padding: const EdgeInsets.all(16),
              child: RefreshIndicator(
                onRefresh: () async {
                  RefreshUserUsecase().execute();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: BlocBuilder<UserBloc, UserState>(
                    bloc: injector.get(),
                    builder: (context, state) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ProfileImageWidget(
                                size: 80,

                                // imageUrl: "${injector.get<LoginBloc>().userPreview?.avatar}"
                              ),
                            ),
                            10.verticalSpace,
                            Center(
                              child: TextView(
                                text: injector.get<UserBloc>().appUser?.name ??
                                    '',
                                style: GoogleFonts.fraunces(
                                    fontSize: 32.sp,
                                    color: Pallets.primaryDark),
                              ),
                            ),
                            18.verticalSpace,
                            Center(
                              child: CustomNeumorphicButton(
                                  expanded: false,
                                  onTap: () {
                                    context
                                        .pushNamed(PageUrl.editProfileScreen);
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 13),
                                  color: Pallets.primary,
                                  child: const TextView(
                                    text: "Edit Profile",
                                    color: Pallets.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            22.verticalSpace,
                            BlocBuilder<UserBloc, UserState>(
                              bloc: injector.get(),
                              builder: (context, state) {
                                return GlassContainer(
                                    child: Padding(
                                  padding: const EdgeInsets.all(17),
                                  child: SettingListTile(
                                    leadingIconUrl: Assets.images.svgs.sub,
                                    onTap: () {
                                      if (injector
                                              .get<UserBloc>()
                                              .appUser
                                              ?.activeSubscription ==
                                          null) {
                                        context.pushNamed(
                                            PageUrl.selectPlanScreen);
                                      } else {
                                        context.pushNamed(
                                            PageUrl.manageSubscriptionScreen);
                                      }
                                    },
                                    tittle: 'Subscription',
                                    trailingWidget: Row(
                                      children: [
                                        TextView(
                                          text: injector
                                                  .get<UserBloc>()
                                                  .appUser
                                                  ?.activeSubscription
                                                  ?.plan
                                                  .name ??
                                              'FREE',
                                          color: Pallets.ink,
                                        ),
                                        8.horizontalSpace,
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                              },
                            ),
                            16.verticalSpace,
                            const SettingsGroup1(),
                            16.verticalSpace,
                            const SettingsGroup2(),
                            16.verticalSpace,
                            const SettingsGroup3(),
                            16.verticalSpace,
                            GlassContainer(
                                child: Padding(
                              padding: const EdgeInsets.all(17),
                              child: SettingListTile(
                                leadingIconUrl: Assets.images.svgs.logout,
                                tittle: 'Logout',
                                onTap: () {
                                  CustomDialogs.showConfirmDialog(
                                    context,
                                    onYes: () {
                                      SessionManager.instance.logOut();
                                      context.goNamed(PageUrl.onBoardingPage);
                                    },
                                    tittle: 'Logout',
                                  );
                                },
                              ),
                            )),
                          ]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
