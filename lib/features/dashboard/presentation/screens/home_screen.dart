import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: 'Mentra',
        leadingWidth: 75,
        actions: [
          CircleAvatar(
            backgroundColor: Pallets.white,
            child: ImageWidget(imageUrl: Assets.images.svgs.arrowLeft),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 1.sw,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(color: Pallets.primary),
                  child: Column(
                    children: [
                      TextView(
                          align: TextAlign.center,
                          style: GoogleFonts.caveat(
                              color: Pallets.white,
                              fontSize: 38.sp,
                              fontWeight: FontWeight.w700),
                          text: "Hello Leila! I'm Mentra"),
                      const TextView(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          align: TextAlign.center,
                          color: Pallets.white,
                          text:
                              "I'm here to help you on your journey to better mental well-being. What’s on your mind today?"),
                      69.verticalSpace,
                      CustomNeumorphicButton(
                        onTap: () {},
                        color: Pallets.secondary,
                        fgColor: Pallets.black,
                        text: "Talk to Mentra",
                      ),
                      50.verticalSpace
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
