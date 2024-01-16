import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';

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
          const AppBg(),
          Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(17)),
                child: Column(
                  children: [
                    const TextView(
                      text: 'Nour Martin, Ph.D.',
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                    10.verticalSpace,
                    const TextView(
                        text:
                            "MDS - Periodonyology and Oral\nImpantology, BDS"),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Pallets.pendingColor,
                            size: 13,
                          ),
                          TextView(
                            text: '4.7',
                            color: Pallets.pendingColor,
                            fontWeight: FontWeight.w600,
                          ),
                          16.verticalSpace,
                          Row(
                            children: [
                              CustomNeumorphicButton(
                                  fgColor: Pallets.black,
                                  padding: const EdgeInsets.all(10),
                                  onTap: () {
                                    context
                                        .pushNamed(PageUrl.therapistChatScreen);
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
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
