import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

class QuestionaireField extends StatelessWidget {
  const QuestionaireField(
      {super.key, required this.controller, required this.question});

  final TextEditingController controller;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // height: 300,

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
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: question,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          5.verticalSpace,
          FilledTextField(
              // maxLine: 5,
              minLine: 5,
              maxLine: 20,
              hasElevation: false,
              contentPadding: EdgeInsets.zero,
              hasBorder: false,
              // expands: true,
              controller: controller,
              fillColor: Colors.transparent,
              hint: 'Not selected'),
        ],
      ),
    );
  }
}
