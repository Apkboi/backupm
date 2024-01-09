import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'image_widget.dart';


class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title,
    this.subtitle,
    required this.imageUrl,
    this.canTryAgain = false,
    this.retryText,
    this.onTap,
  });

  final String? title;
  final String? subtitle;
  final String imageUrl;
  final String? retryText;
  final bool? canTryAgain;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          24.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(imageUrl: imageUrl),
            ],
          ),
          24.verticalSpace,
          TextView(
            text: title ?? 'No activity to show !',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          11.verticalSpace,
          if (subtitle?.isNotEmpty ?? false)
            TextView(
              text: subtitle ??
                  'You don’t have any transactions done. Once you make any transactions it will show here.',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              align: TextAlign.center,
            ),
          if (canTryAgain!)
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Pallets.primary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 8),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Pallets.primary, width: 2),
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(retryText ?? "Retry"),
                )
              ],
            )
        ],
      ),
    );
  }
}
