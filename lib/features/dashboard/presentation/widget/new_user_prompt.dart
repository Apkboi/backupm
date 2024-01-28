import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/dashboard/presentation/widget/unlock_premmium_feature_dialog.dart';

class NewUserPrompt extends StatelessWidget {
  const NewUserPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextView(
                    text: 'Connect with Mentra',
                    style: GoogleFonts.fraunces(
                        fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  8.verticalSpace,
                  const TextView(
                    text:
                        'Click below to \'Talk to Mentra\' and share how you\'re doing, ask questions, or just have a friendly chat.  Ready when you are!',
                    color: Pallets.ink,
                    align: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                  10.verticalSpace,
                  CustomNeumorphicButton(
                      expanded: true,
                      text: 'Talk to Mentra',
                      fgColor: Pallets.white,
                      padding: const EdgeInsets.all(16),
                      onTap: () {
                        context.pushNamed(PageUrl.talkToMentraScreen);
                      },
                      color: Pallets.primary)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
