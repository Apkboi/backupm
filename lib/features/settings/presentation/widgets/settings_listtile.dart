import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';


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
    return HapticInkWell(
      onTap: onTap,
      child: Row(
        children: [
          leadingWidget != null
              ? SizedBox(
                  width: 30.w,
                  child: Center(
                    child: leadingWidget,
                  ),
                )
              : leadingIconUrl != null
                  ? SizedBox(
                      width: 30.w,
                      child: Center(
                        child: ImageWidget(
                          imageUrl: leadingIconUrl ?? '',
                          size: 18.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : 0.horizontalSpace,
          17.horizontalSpace,
          Expanded(
            child: TextView(
              text: tittle,
              // style: ,
              fontSize: 15,
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
