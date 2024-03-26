import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/theme/pallets.dart';
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
    return InkWell(
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
        radius: widget.size ?? 23,
        child: Center(
          child: widget.icon ??
              ImageWidget(imageUrl: Assets.images.svgs.arrowLeft),
        ),
      ),
    );
  }
}
