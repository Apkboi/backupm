import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {Key? key, required this.tittle, required this.onClose, this.btnText})
      : super(key: key);
  final String tittle;
  final String? btnText;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Container(
        decoration: BoxDecoration(
            color: Pallets.white, borderRadius: BorderRadius.circular(21)),
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
              37.verticalSpace,
              ImageWidget(
                imageUrl: Assets.images.svgs.success,
              ),
              10.verticalSpace,
              TextView(
                text: tittle,
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                    fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomNeumorphicButton(
                    expanded: false,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                    onTap: () {
                      onClose();
                      // context.pop(true);
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
                    text: btnText ?? "Done",
                  ),
                ],
              ),
              17.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
