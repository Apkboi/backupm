import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/core/constants/package_exports.dart';

class TextView extends StatelessWidget {
  final GlobalKey? textKey;
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? align;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Function()? onTap;
  final int? maxLines;
  final TextStyle? style;
  final TextDecoration? decoration;

  const TextView({
    super.key,
    this.textKey,
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.align = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize,
    this.lineHeight,
    this.style,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.decoration,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        key: textKey,

        // textScaleFactor: ScreenUtil().textScaleFactor,
        style: style?.copyWith(inherit: true) ??
            GoogleFonts.plusJakartaSans(
              color: color,
              decoration: decoration,
              fontWeight: fontWeight,
              fontSize: fontSize?.sp ?? 14.sp,
              fontStyle: fontStyle,
              height: lineHeight,
            ).copyWith(inherit: true),
        textAlign: align,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}
