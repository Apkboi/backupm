import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomButton(
        foregroundColor: Pallets.black,
        bgColor: Pallets.white,
        isExpanded: false,
        elevation: 0,
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(100),
        // onPressed: () {
        //   context
        //       .read<TherapyBloc>()
        //       .add(const MatchTherapistEvent(updatedPreference: false));
        // },
        onPressed: onTap,
        child: TextView(
          text: 'Retry',
          style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
      ),
    );
  }
}
