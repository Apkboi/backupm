import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';

class ViewProfileButton extends StatelessWidget {
  const ViewProfileButton({super.key, required this.therapist});

  final SuggestedTherapist therapist;

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
        child: TextView(
          text: 'View ${therapist.user.name}\'s Profile',
          style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        onPressed: () async {
          final bool? matched = await context
              .pushNamed(PageUrl.acceptTherapistScreen, queryParameters: {
            PathParam.therapist: jsonEncode(therapist.toJson())
          });

          if (matched != null) {
            if (matched) {
              context.read<TherapyBloc>().add(TherapistAcceptedEvent());
            } else {
              context
                  .read<TherapyBloc>()
                  .add(const MatchTherapistEvent(updatedPreference: false));
            }
          }
        },
      ),
    );
  }
}
