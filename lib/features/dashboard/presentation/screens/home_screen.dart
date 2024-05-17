import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/screens/intro_demo.dart';
import 'package:mentra/common/screens/local_render_screen.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/daily_streak/daily_streak_checker.dart';
import 'package:mentra/core/services/pay/pay_service.dart';
import 'package:mentra/core/services/stripe/stripe_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/dashboard/dormain/usecase/dashboard_usecase.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/dashboard/presentation/widget/home_bot_image.dart';
import 'package:mentra/features/therapy/presentation/screens/call_listener.dart';
import 'package:mentra/features/therapy/presentation/screens/incoming_call_screen.dart';
import 'package:mentra/features/therapy/presentation/widgets/confirm_session_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/end_therapy_session_dialog.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_review_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';
import '../../../../core/navigation/route_url.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, this.startConvo = false, this.authenticate = false});

  final bool startConvo;
  final bool authenticate;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _welcome();
    DashboardUsecase().execute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Pallets.primary,
      appBar: CustomAppBar(
        tittle: ImageWidget(
          imageUrl: Assets.images.svgs.mentraText,
          width: 99.7.w,
          height: 24.h,
          color: Pallets.primary,
        ),
        height: 80,
        leadingWidth: 80,
        actions: [
          HapticInkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>
              //     IncomingCallScreen(
              //         callerId: 'callerId', calleeId: 'calleeId'),));
              context.pushNamed(PageUrl.menuScreen);
              // _welcome();
              // DashboardUsecase().execute();
            },
            child: CircleAvatar(
              backgroundColor: Pallets.white,
              radius: 25,
              child: ImageWidget(imageUrl: Assets.images.svgs.menuIcon),
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
            padding: const EdgeInsets.all(8),
            text: 'SOS',
          ),
        ),
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          Container(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: -280.h,
                        right: 0,
                        left: 0,
                        child: const HomeBotImage()),
                    Positioned(
                        top: -98,
                        right: 0,
                        left: 0,
                        child: ImageWidget(
                            width: 1.sw,
                            height: 254,
                            fit: BoxFit.fitWidth,
                            imageUrl: Assets.images.svgs.combinedShape)),
                    Container(
                      width: 1.sw,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(color: Pallets.primary),
                      child: BlocConsumer<DashboardBloc, DashboardState>(
                        bloc: injector.get(),
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is GetConversationStarterFailureState) {
                            return SizedBox(
                              height: 300,
                              child: AppPromptWidget(
                                retryTextColor: Pallets.white,
                                textColor: Pallets.white,
                                onTap: () {
                                  injector
                                      .get<DashboardBloc>()
                                      .add(GetConversationStarterEvent());
                                },
                              ),
                            );
                          }
                          if (state is GetConversationStarterLoadingState) {
                            return SizedBox(
                              height: 250,
                              child: CustomDialogs.getLoading(
                                  size: 30, color: Pallets.white),
                            );
                          }

                          return Column(
                            children: [
                              TextView(
                                  align: TextAlign.center,
                                  style: GoogleFonts.caveat(
                                      color: Pallets.white,
                                      fontSize: 38.sp,
                                      fontWeight: FontWeight.w700),
                                  text: injector
                                          .get<DashboardBloc>()
                                          .conversationStarter
                                          ?.data
                                          .title ??
                                      ''),
                              TextView(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  align: TextAlign.center,
                                  color: Pallets.white,
                                  text: injector
                                          .get<DashboardBloc>()
                                          .conversationStarter
                                          ?.data
                                          .message ??
                                      ''),
                              69.verticalSpace,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: CustomNeumorphicButton(
                                  onTap: () async {
                                    // var currentCall = await getCurrentCall();

                                    // CallKitService.instance.checkAndNavigationCallingPage();

                                    // context
                                    //     .pushNamed(PageUrl.talkToMentraScreen);

                                    StripeService().initPaymentSheet();
                                    // CallKitService.instance.showIncomingCall(
                                    //     'callerId', 'callerName');
                                  },
                                  color: Pallets.secondary,
                                  fgColor: Pallets.navy,
                                  padding: EdgeInsets.symmetric(vertical: 19.h),
                                  text: "Talk to Mentra",
                                ),
                              ),
                              50.verticalSpace
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _welcome() async {
    DailyStreakChecker.checkForStreak();
  }
}
