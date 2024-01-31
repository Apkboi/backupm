import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'package:mentra/gen/assets.gen.dart';

class TherapistProfileScreen extends StatefulWidget {
  const TherapistProfileScreen({super.key});

  @override
  State<TherapistProfileScreen> createState() => _TherapistProfileScreenState();
}

class _TherapistProfileScreenState extends State<TherapistProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 100.verticalSpace,
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: Pallets.primary,
                              image: DecorationImage(
                                  image: AssetImage(
                                      Assets.images.pngs.avatar20.path))),
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 60.0, left: 16),
                              child: CustomBackButton(),
                            ),
                          ),
                        ),
                        200.verticalSpace
                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Container(
                            width: 1.sw,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Pallets.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const TextView(
                                  text: 'Nour Martin, Ph.D.',
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
                                10.verticalSpace,
                                const TextView(
                                    align: TextAlign.center,
                                    text:
                                    "MDS - Periodonyology and Oral\nImpantology, BDS"),
                                16.verticalSpace,
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                      Pallets.pendingColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Pallets.pendingColor,
                                          size: 13,
                                        ),
                                        const TextView(
                                          text: '4.7',
                                          color: Pallets.pendingColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        16.verticalSpace,
                                      ],
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomNeumorphicButton(
                                        fgColor: Pallets.black,
                                        padding: const EdgeInsets.all(10),
                                        onTap: () {
                                          context.pushNamed(
                                              PageUrl.therapistChatScreen);
                                        },
                                        text: "Message Nour",
                                        color: Pallets.milkColor),
                                    8.horizontalSpace,
                                    CustomOutlinedButton(
                                      bgColor: Colors.white,
                                      outlinedColr: Pallets.primary,
                                      padding: const EdgeInsets.all(10),
                                      radius: 148,
                                      child: const TextView(
                                        text: 'Change Therapist',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      onPressed: () {

                                        // _cancelTherapySession(context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: 100,color: Pallets.black,)
                // IgnorePointer(
                //   ignoring: true,
                //   child: 0.2.sh.verticalSpace,
                // ),
                // IgnorePointer(
                //   ignoring: true,
                //   child: Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const TextView(
                //           text: 'About Nour',
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //         ),
                //         16.verticalSpace,
                //         const TherapistAboutWidget(),
                //         16.verticalSpace,
                //         const TextView(
                //           text: 'Specializations',
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //         ),
                //         16.verticalSpace,
                //         const TherapistSpecializationWidget(),
                //         16.verticalSpace,
                //         const TextView(
                //           text: 'Reviews',
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //         ),
                //         16.verticalSpace,
                //         const TherapistsReviewWidget()
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
