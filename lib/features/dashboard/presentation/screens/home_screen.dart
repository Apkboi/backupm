import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/screens/intro_demo.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/daily_streak/daily_streak_checker.dart';
import 'package:mentra/core/services/pay/pay_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/dashboard/dormain/usecase/dashboard_usecase.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/dashboard/presentation/widget/home_bot_image.dart';
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
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           Intro(child: const DemoUsage()),
                                    //     ));
                                    context
                                        .pushNamed(PageUrl.talkToMentraScreen);

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

  //
  // void _showCardDialog(BuildContext context) {
  //   CustomDialogs.showBottomSheet(
  //     context,
  //     const CardDetailsSheet(),
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(16),
  //       topRight: Radius.circular(16),
  //     )),
  //   );
  // }

  void _welcome() async {
    DailyStreakChecker.checkForStreak();
  }
}

// Future<void> _handlePayPress() async {
//   double price = 100.5;
//   int constPrice = (price * 100).toInt();
//   try {
//     final paymentMethod = await Stripe.instance.createPlatformPayPaymentMethod(
//         params: const PlatformPayPaymentMethodParamsGooglePay(
//             googlePayParams: GooglePayParams(
//                 testEnv: true, merchantCountryCode: 'CA', currencyCode: "CAD"),
//             googlePayPaymentMethodParams: GooglePayPaymentMethodParams(
//                 amount: 50,
//                 billingAddressConfig:
//                     GooglePayBillingAddressConfig(isRequired: true),
//                 shippingAddressConfig:
//                     GooglePayShippingAddressConfig(isRequired: true)))
//
//         // GooglePayParams(
//         //   merchantCountryCode: "CA",
//         //   currencyCode: "CAD",
//         //   merchantName: "Tingsapp",
//         //   isEmailRequired: true,
//         //   testEnv: true,
//         // ),
//         // GooglePayPaymentMethodParams(
//         //   amount: constPrice,
//         //   billingAddressConfig: GooglePayBillingAddressConfig(isRequired: true),
//         //   shippingAddressConfig: GooglePayShippingAddressConfig(isRequired: true),
//         // ),
//         );
//     // handlePaymentMethod(paymentMethod);
//   } catch (e) {
//     if (e is StripeException) {
//       debugPrint('Stripe exception google pay,,,,,,,,,,,,,,,, ${e.error}');
//     } else {
//       debugPrint('General pay error >>>>>>>>>>>>>>> $e');
//     }
//     // setState(() {});
//   }
// }
//
// Future<void> _handlePaymentRequest() async {
//   StripeService().initPaymentSheet();
//   // await Stripe.instance.presentPaymentSheet();
// }
