import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {super.key, this.tittle, this.message, this.onTap, this.btnText});

  final String? tittle;
  final String? btnText;
  final String? message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Pallets.successGreen,
        // borderRadius: BorderRadius.circular(16)
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
          ImageWidget(
            imageUrl: "Assets.images.svgs.success",
            height: 90,
          ),
          10.verticalSpace,
          TextView(
            text: tittle ?? "Successful !!",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            align: TextAlign.center,
            color: Pallets.white,
          ),
          17.verticalSpace,
          TextView(
            align: TextAlign.center,
            text: message ?? "Congratulations !!",
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Pallets.white,
          ),
          40.verticalSpace,
          CustomButton(
              bgColor: Pallets.white,
              elevation: 0,
              padding: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(8),
              foregroundColor: Pallets.successGreen,
              onPressed: onTap ?? () {},
              child: TextView(
                text: btnText ?? 'Back to Home',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          40.verticalSpace
        ],
      ),
    );
  }
}
