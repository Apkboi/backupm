import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile(
      {super.key,
      this.leadingIconUrl,
      this.leadingWidget,
      this.trailingWidget,
      required this.tittle,
      this.hasArrow = true,
      this.onTap});

  final String? leadingIconUrl;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final String tittle;
  final bool? hasArrow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          leadingWidget ?? ImageWidget(imageUrl: leadingIconUrl ?? ''),
          17.horizontalSpace,
          Expanded(
            child: TextView(
              text: tittle,
              fontWeight: FontWeight.w600,
            ),
          ),
          10.horizontalSpace,
          trailingWidget ??
              (hasArrow!
                  ? const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    )
                  : 0.horizontalSpace)
        ],
      ),
    );
  }
}
