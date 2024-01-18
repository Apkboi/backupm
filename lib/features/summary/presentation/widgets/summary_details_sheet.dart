import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/summary/presentation/widgets/confirm_delete_summary_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SummaryDetailsSheet extends StatefulWidget {
  const SummaryDetailsSheet({Key? key}) : super(key: key);

  @override
  State<SummaryDetailsSheet> createState() => _SummaryDetailsSheetState();
}

class _SummaryDetailsSheetState extends State<SummaryDetailsSheet> {
  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
        transitionBackgroundColor: Pallets.bottomSheetColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
                  TextButton(
                      onPressed: () {
                        _deleteSummary(context);
                      },
                      child: const Text('Delete'))
                ],
              ),
              TextView(
                text: 'Summary of Your session with Mentra',
                align: TextAlign.start,
                style: GoogleFonts.fraunces(
                    fontSize: 32, fontWeight: FontWeight.w600),
              ),
              16.verticalSpace,
              const TextView(
                text: '2 May',
                fontWeight: FontWeight.w600,
                color: Pallets.ink,
              ),
              16.verticalSpace,
              const TextView(
                text:
                    'Hi there! Here\'s a quick recap of your recent\nsession with Mentra:',
              ),
              16.verticalSpace,
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SummaryDetailItem(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomNeumorphicButton(
                  onTap: () {},
                  color: Pallets.primary,
                  text: 'Share',
                ),
              )
            ],
          ),
        ));
  }

  void _deleteSummary(BuildContext context) async {
    final deleteSummary = await CustomDialogs.showBottomSheet(
        context, const ConfirmDeleteSummarySheet());

  }
}

class SummaryDetailItem extends StatelessWidget {
  const SummaryDetailItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
          text: 'Main Topics Discussed:',
        ),
        16.verticalSpace,
        ...List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Icon(
                          Icons.circle,
                          color: Pallets.black,
                          size: 6,
                        ),
                      ),
                      5.horizontalSpace,
                      const Expanded(
                        child: TextView(
                          text:
                              'Try the \'5-5-5\' breathing exercise for immediate stress relief immediate stress .',
                        ),
                      ),
                    ],
                  ),
                ))
      ],
    );
  }
}
