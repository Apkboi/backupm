import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';

class SessionFocusSheet extends StatelessWidget {
  SessionFocusSheet({super.key});

  List sessionFocuses = ["Depression", "Health", "Mental disorder"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Pallets.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: 'Select session focus',
            style: GoogleFonts.sora(
              fontSize: 20.sp,
            ),
          ),
          20.verticalSpace,
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: sessionFocuses.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.pop(sessionFocuses[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextView(
                    text: sessionFocuses[index],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
