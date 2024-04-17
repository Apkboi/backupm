import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

class DeleteAccountReason extends StatelessWidget {
  DeleteAccountReason({super.key, required this.onDelete});

  final VoidCallback? onDelete;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Pallets.bottomSheetColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                text: "Why did you decide to leave Mentra?",
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                    fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              22.verticalSpace,
              const TextView(
                text:
                    "Before you go, could you share the reason for deleting your account? Your insights matter to us.",
                align: TextAlign.center,
                fontWeight: FontWeight.w500,
                color: Pallets.ink,
              ),
              20.verticalSpace,
              AppFilledTextField(
                hint: 'Not Selected',
                label: "Please tell us more",
                maxLines: 5,
                controller: _controller,
              ),
              20.verticalSpace,
              CustomNeumorphicButton(
                onTap: () {
                  _delete(context);
                },
                color: Pallets.red,
                text: "Yes, I want to delete it.",
              ),
              17.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _delete(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.pop(_controller.text.toString());
    }
  }
}
