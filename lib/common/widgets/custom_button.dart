import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;
  final BorderRadius? borderRadius;
  final double? elevation;
  final String? btnText;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;

  const CustomButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.bgColor,
      this.padding,
      this.isExpanded = true,
      this.foregroundColor,
      this.borderRadius,
      this.elevation,
      this.btnText,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.mainAxisSize = MainAxisSize.min})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: widget.elevation,
        padding: widget.padding ?? const EdgeInsets.all(13),
        foregroundColor:
            widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(5)),
        disabledBackgroundColor: widget.bgColor == null
            ? Theme.of(context).colorScheme.primary.withAlpha(-200)
            : widget.bgColor!.withAlpha(-200),
        backgroundColor:
            widget.bgColor ?? Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment!,
        mainAxisSize: widget.isExpanded! ? MainAxisSize.max : MainAxisSize.min,
        children: [widget.child],
      ),
    );
  }
}
