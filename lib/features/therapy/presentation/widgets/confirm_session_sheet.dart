import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/session_scheduled_dialog.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConfirmSessionSheet extends StatefulWidget {
  const ConfirmSessionSheet({super.key});

  @override
  State<ConfirmSessionSheet> createState() => _ConfirmSessionSheetState();
}

class _ConfirmSessionSheetState extends State<ConfirmSessionSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Pallets.bottomSheetColor,
      child: CupertinoScaffold(
          transitionBackgroundColor: Pallets.bottomSheetColor,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Pallets.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                16.verticalSpace,
                TextView(
                  text: 'Confirm your session',
                  style: GoogleFonts.fraunces(
                      color: Pallets.navy,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600),
                ),
                16.verticalSpace,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Pallets.white,
                      borderRadius: BorderRadius.circular(17)),
                  child: Row(
                    children: [
                       Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ImageWidget(imageUrl: Assets.images.svgs.icCalender),
                                10.horizontalSpace,

                                const     TextView(
                                  text: ' Saturday, 02 December 2023',
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            10.verticalSpace,

                            Row(
                              children: [
                                ImageWidget(imageUrl: Assets.images.svgs.icClock),
                                10.horizontalSpace,
                                const TextView(
                                  text: ' 9:00 am',
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Change',
                            style: TextStyle(
                                color: Pallets.primary,
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                ),
                16.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                      color: Pallets.white,
                      borderRadius: BorderRadius.circular(17)),
                  padding: const EdgeInsets.all(16),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: 'Session Focus',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            TextView(text: 'Building Self-Confidence'),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Pallets.black,
                      )
                    ],
                  ),
                ),
                16.verticalSpace,
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                      color: Pallets.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: Colors.grey.withOpacity(
                                0.3,
                              ),
                              width: 0.8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextView(
                            text: 'Note',
                            style: GoogleFonts.inter(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          TextView(
                            text: ' (Optional)',
                            style: GoogleFonts.inter(
                                fontSize: 12, color: Pallets.grey),
                          ),
                        ],
                      ),
                      7.verticalSpace,
                      const FilledTextField(
                          maxLine: 5,
                          hasElevation: false,
                          contentPadding: EdgeInsets.zero,
                          hasBorder: false,
                          fillColor: Colors.transparent,
                          hint: 'Not Selected'),
                    ],
                  ),
                ),
                Expanded(child: 16.verticalSpace),
                CustomNeumorphicButton(
                    text: 'Continue',
                    onTap: () {
                      _closeAllSheets(context);
                    },
                    color: Pallets.primary)
              ],
            ),
          )),
    );
  }

  void _closeAllSheets(BuildContext context) {
    context.pop();
    context.pop();
    context.pop();

    CustomDialogs.showCustomDialog(const SessionScheduledDialog(), context);
  }
}
