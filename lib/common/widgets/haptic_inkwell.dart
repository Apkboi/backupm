import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:mentra/core/services/vibration/haptic_feedback_manager.dart';

class HapticInkWell extends StatelessWidget {
  final bool enableHapticsOnTap;
  final bool enableHapticsOnLongPress;
  final bool enableHapticsOnDoubleTap;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final Widget? child;
  final Key? key;
  final BorderRadius? borderRadius;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final Color? color;
  final double? radius;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusBottomRight;
  final double? borderRadiusTopLeft;
  final double? borderRadiusTopRight;
  final ShapeBorder? customBorder;
  final EdgeInsetsGeometry? insets;
  final FocusNode? focusNode;
  final bool? canRequestFocus;
  final FocusNode? focusNodeObj;
  final bool? autofocus;
  final MouseCursor? mouseCursor;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHover;
  final String? cursorName;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;

  const HapticInkWell({
    this.enableHapticsOnTap = true,
    this.enableHapticsOnLongPress = true,
    this.enableHapticsOnDoubleTap = true,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.child,
    this.key,
    this.borderRadius,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.splashFactory,
    this.color,
    this.radius,
    this.borderRadiusBottomLeft,
    this.borderRadiusBottomRight,
    this.borderRadiusTopLeft,
    this.borderRadiusTopRight,
    this.customBorder,
    this.insets,
    this.focusNode,
    this.canRequestFocus,
    this.focusNodeObj,
    this.autofocus,
    this.mouseCursor,
    this.onFocusChange,
    this.onHover,
    this.cursorName,
    this.onEnter,
    this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap!();

        if (enableHapticsOnTap) {
          HapticFeedbackManager.vibrate();
        }

        await Future.delayed(Duration(milliseconds: 300));
        //
        // if (onTap != null) {
        // }
      },
      onDoubleTap: null,
      onLongPress: null,
      child: child,
      key: key,
      borderRadius: borderRadius,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      overlayColor: overlayColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      radius: radius,
      customBorder: customBorder,
      // insets: insets,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus ?? true,
      autofocus: autofocus ?? false,
      mouseCursor: mouseCursor,
      onFocusChange: onFocusChange,
      onHover: onHover,
      // cursorName: cursorName,
      // onEnter: onEnter,
      // onExit: onExit,
    );
  }
}
