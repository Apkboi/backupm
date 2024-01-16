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
import 'package:mentra/features/therapy/presentation/widgets/session_canceled_dialog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CancelSessionSheet extends StatefulWidget {
  const CancelSessionSheet({super.key});

  @override
  State<CancelSessionSheet> createState() => _CancelSessionSheetState();
}

class _CancelSessionSheetState extends State<CancelSessionSheet> {
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
                  text: 'Cancel your therapy session with Nour ',
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
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ImageWidget(imageUrl: ''),
                                TextView(
                                  text: ' Saturday, 02 December 2023',
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ImageWidget(imageUrl: ''),
                                TextView(
                                  text: ' 9:00 am',
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                            text: 'Send a personal message to Sami Al-Fayed',
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
                          hint:
                              'Let the other party know why you are canceling this session'),
                    ],
                  ),
                ),
                Expanded(child: 16.verticalSpace),
                CustomNeumorphicButton(
                    text: 'Cancel Session',
                    onTap: () {
                      _cancelSessions(context);
                    },
                    color: Pallets.primary)
              ],
            ),
          )),
    );
  }

  void _cancelSessions(BuildContext context) async {
    await CustomDialogs.showBottomSheet(context, const SessionCanceledDialog(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        constraints: BoxConstraints(maxHeight: 0.9.sh));

    context.pop(true);
  }
}
