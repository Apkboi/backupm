import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/vibration/haptic_feedback_manager.dart';
import 'package:mentra/core/theme/pallets.dart';

// import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class CustomNeumorphicButton extends StatelessWidget {
  const CustomNeumorphicButton(
      {super.key,
      this.text,
      required this.onTap,
      required this.color,
      this.fgColor = Pallets.white,
      this.expanded = true,
      this.child,
      this.padding,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.shape});

  final String? text;
  final Widget? child;
  final VoidCallback onTap;
  final Color color;
  final Color? fgColor;
  final bool? expanded;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedbackManager.vibrate();
        onTap();
      },
      child: SizedBox(
        child: Container(
          constraints:
              expanded! ? BoxConstraints(maxWidth: 1.sw - 127.w) : null,
          decoration: ShapeDecoration(
            color: color,
            shape: shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                ),
          ),
          child: Container(
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, -1.00),
                end: const Alignment(0, 1),
                colors: [
                  Colors.white.withOpacity(0.32),
                  color.withOpacity(0.9),
                  color.withOpacity(0.9),
                  color.withOpacity(0.9),
                  color.withOpacity(0.9)
                ],
              ),
              shape: shape ??
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150),
                      side: BorderSide(color: color)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.5),
              child: Container(
                decoration: ShapeDecoration(
                  color: color,
                  shape: shape ??
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                ),
                child: Padding(
                  padding: padding ??
                      const EdgeInsets.symmetric(
                          vertical: 17.0, horizontal: 30),
                  child: expanded!
                      ? Row(
                          mainAxisAlignment: mainAxisAlignment!,
                          // mainAxisSize: expanded! ? MainAxisSize.max : MainAxisSize.min,
                          children: [
                            IgnorePointer(
                              ignoring: true,
                              child: Center(
                                child: child ??
                                    TextView(
                                      text: text ?? 'Button',
                                      align: TextAlign.center,
                                      style: TextStyle(
                                        color: fgColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        )
                      : child ??
                          TextView(
                            text: text ?? 'Button',
                            align: TextAlign.center,
                            color: fgColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            // style: TextStyle(
                            //
                            // ),
                          ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


