import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class ContinueChatDialog extends StatelessWidget {
  const ContinueChatDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: const BoxDecoration(
          color: Pallets.bottomSheetColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 49,
              height: 5,
              decoration: ShapeDecoration(
                color: const Color(0xFFBCC4CC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
            ),
            10.verticalSpace,
            TextView(
              text: 'Continue where you\nleft Off ?',
              align: TextAlign.center,
              style: GoogleFonts.fraunces(
                  fontSize: 23.sp, fontWeight: FontWeight.w600),
            ),
            22.verticalSpace,
            // const TextView(
            //   text: 'You can continue your chat with Mentra or start fresh conversation.',
            //   align: TextAlign.center,
            //   fontWeight: FontWeight.w500,
            //   color: Pallets.ink,
            // ),
            // 20.verticalSpace,
            CustomNeumorphicButton(

              padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 16),
              onTap: () {
                context.pop();

                // context.pop();
                // CustomDialogs.showBottomSheet(
                //     context, const EndSessionDialog(),
                //     shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(16),
                //           topRight: Radius.circular(16),
                //         )),
                //     constraints: BoxConstraints(maxHeight: 0.9.sh));
              },
              color: Pallets.primary,
              expanded: false,
              text: "Yes",
            ),
            17.verticalSpace,
            CustomOutlinedButton(
              outlinedColr: Pallets.primary,
              bgColor: Pallets.white,
              padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 15),
              isExpanded: false,
              onPressed: () {
                context.pop(true);

              },
              radius: 100,

              child: const TextView(
                text: 'No',
                fontWeight: FontWeight.w600,
              ),
            ),
            17.verticalSpace,
          ],
        ),
      ),
    );
  }
}
