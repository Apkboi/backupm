import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? foreGroundColor;
  final Color? outlinedColr;
  final double? radius;
  final double? outlineWidth;
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;
  final MainAxisAlignment? mainAxisAlignment;

  const CustomOutlinedButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.bgColor,
      this.foreGroundColor,
      this.padding,
      this.isExpanded = true,
      this.outlinedColr,
      this.radius,
      this.outlineWidth,
      this.mainAxisAlignment})
      : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:widget.isExpanded!? 1.sw - 127.w:null,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          padding: widget.padding ?? const EdgeInsets.all(16),
          foregroundColor: widget.foreGroundColor ??
              Theme.of(context).colorScheme.onBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 10),
            side: BorderSide(
              width: widget.outlineWidth ?? 1,
              color: widget.outlinedColr ??
                  Theme.of(context).colorScheme.onBackground,
            ),
          ),
          elevation: 0,
          // disabledBackgroundColor: Theme.of(context).primaryColor.withAlpha(-200),
          backgroundColor: widget.bgColor ?? Colors.transparent,
        ),
        child: Row(
          mainAxisSize:
              widget.isExpanded! ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.child,
          ],
        ),
      ),
    );
  }
}
