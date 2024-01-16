import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/widgets/cancel_session_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TherapyDetailsSheet extends StatefulWidget {
  const TherapyDetailsSheet({super.key});

  @override
  State<TherapyDetailsSheet> createState() => _TherapyDetailsSheetState();
}

class _TherapyDetailsSheetState extends State<TherapyDetailsSheet> {
  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      transitionBackgroundColor: Pallets.bottomSheetColor,
      // backgroundColor: Pallets.bottomSheetColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              ImageWidget(
                imageUrl: Assets.images.svgs.avatar1,
                height: 64.h,
                width: 64.w,
              ),
              6.verticalSpace,
              TextView(
                text: 'Building Self-\nConfidence',
                style: GoogleFonts.fraunces(
                    color: Pallets.navy,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600),
              ),
              8.verticalSpace,
              const TextView(
                  text: 'Session with Nour Martin, Ph.D.',
                  color: Pallets.brandColor,
                  fontWeight: FontWeight.w600),
              17.verticalSpace,
              Row(
                children: [
                  CustomNeumorphicButton(
                      fgColor: Pallets.black,
                      padding: const EdgeInsets.all(10),
                      onTap: () {
                        context.pushNamed(PageUrl.therapistChatScreen);
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
                      text: 'Cancel Session',
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      _cancelTherapySession(context);
                    },
                  ),
                ],
              ),
              48.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: 'Status',
                      color: Pallets.ink,
                    ),
                    TextView(
                      text: 'Awaiting',
                      color: Pallets.mildOrange,
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: 'Date',
                          color: Pallets.ink,
                        ),
                        TextView(
                          text: 'December 5, 2023',
                          // color: Pallets.mildOrange,
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: 'Time',
                          color: Pallets.ink,
                        ),
                        TextView(
                          text: '3:00 PM',
                          // color: Pallets.mildOrange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: 'Your notes',
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    const TextView(
                      text:
                          'Working on self-esteem issues that have been affecting my social interactions.',
                    ),
                  ],
                ),
              ),
              77.verticalSpace,
              Center(
                child: CustomNeumorphicButton(
                  onTap: () {},
                  color: Pallets.primary,
                  expanded: false,
                  text: "Reschedule Session",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cancelTherapySession(BuildContext context) async {
    final bool? canceled = await CustomDialogs.showCupertinoBottomSheet(
        context, const CancelSessionSheet());

    if (canceled ?? false) {
      context.pop();
    }
  }
}
