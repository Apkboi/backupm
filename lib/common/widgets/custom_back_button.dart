import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/gen/assets.gen.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({super.key, this.icon, this.onTap, this.size});

  final Widget? icon;
  final double? size;
  final VoidCallback? onTap;

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return HapticInkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          Navigator.pop(context);
        }
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.transparent,
        radius: widget.size?.r ?? 20.r,
        child: Center(
          child: widget.icon ??
              ImageWidget(imageUrl: Assets.images.svgs.arrowLeft,size: 18.r,),
        ),
      ),
    );
  }
}
