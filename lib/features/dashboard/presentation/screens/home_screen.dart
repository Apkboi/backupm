import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/navigation/route_url.dart';

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
          InkWell(
            onTap: () {
              context.pushNamed(PageUrl.menuScreen);
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
            onTap: () {},
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: -350.h,
                        right: 0,
                        left: 0,
                        child: ImageWidget(
                          imageUrl: Assets.images.pngs.mentra.path,
                          height: 350.h,
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                        top: -100,
                        child: ImageWidget(
                            imageUrl: Assets.images.svgs.combinedShape)),
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
                              text:
                                  "Hello ${injector.get<UserBloc>().appUser?.name}! I'm Mentra"),
                          const TextView(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              align: TextAlign.center,
                              color: Pallets.white,
                              text:
                                  "I'm here to help you on your journey to better mental well-being. What’s on your mind today?"),
                          69.verticalSpace,
                          CustomNeumorphicButton(
                            onTap: () {
                              // context.pushNamed(PageUrl.talkToMentraScreen);
                              CustomDialogs.showCupertinoDialog(
                                  context,
                                  Container(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                                onTap: () =>
                                                    showCupertinoModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container();
                                                      },
                                                    ),
                                                child: Text('c askj'))),
                                  ));
                            },
                            color: Pallets.secondary,
                            fgColor: Pallets.black,
                            text: "Talk to Mentra",
                          ),
                          50.verticalSpace
                        ],
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
}
