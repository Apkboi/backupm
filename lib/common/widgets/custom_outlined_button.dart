import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? foreGroundColor;
  final Color? outlinedColr;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;

  const CustomOutlinedButton(
      {Key? key,
        required this.child,
        required this.onPressed,
        this.bgColor,
        this.foreGroundColor,
        this.padding,
        this.isExpanded = true,
        this.outlinedColr,
        this.radius})
      : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            flex: widget.isExpanded! ? 1 : 0,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: OutlinedButton.styleFrom(
                padding: widget.padding ?? const EdgeInsets.all(16),
                foregroundColor: widget.foreGroundColor ??
                    Theme.of(context).colorScheme.onBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 10),
                  side: BorderSide(
                    color: widget.outlinedColr ??
                        Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                elevation: 0,
                // disabledBackgroundColor: Theme.of(context).primaryColor.withAlpha(-200),
                backgroundColor: widget.bgColor ?? Colors.transparent,
              ),
              child: widget.child,
            )),
      ],
    );
  }
}
