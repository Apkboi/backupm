import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/core/theme/pallets.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({super.key, required this.child, this.radius});

  final Widget child;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      // color: Pallets.grey,
      decoration: ShapeDecoration(
          // color: Pallets.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius??20),
              side: const BorderSide(color: Pallets.white, width: 0.5))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 18),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: child,
        ),
      ),
    );
  }
}
