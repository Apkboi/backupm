import 'package:flutter/material.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

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
      this.mainAxisAlignment = MainAxisAlignment.center});

  final String? text;
  final Widget? child;
  final VoidCallback onTap;
  final Color color;
  final Color? fgColor;
  final bool? expanded;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(

          decoration: ShapeDecoration(

            gradient: LinearGradient(
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [
                Colors.white60,
                color.withOpacity(0.9),
                color.withOpacity(0.9),
                color.withOpacity(0.9),
                color.withOpacity(0.9)
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150),
                side: BorderSide(color: color)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
              child: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment!,
                  mainAxisSize: expanded! ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    Center(
                      child: child ??
                          Text(
                            text ?? 'Button',
                            style: TextStyle(
                                color: fgColor, fontWeight: FontWeight.w600),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomNeumorphicButton extends StatelessWidget {
//   const CustomNeumorphicButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width: 67,
//       // height: 34,
//       padding: const EdgeInsets.all(16),
//       clipBehavior: Clip.antiAlias,
//       decoration: ShapeDecoration(
//         // gradient: LinearGradient(
//         //   begin: const Alignment(0.00, -1.00),
//         //   end: Alignment(0, 1),
//         //   colors: [Colors.white, Colors.white.withOpacity(0)],
//         // ),
//         // color: Pallets.primary,
//         shape: RoundedRectangleBorder(
//
//           side: BorderSide(
//             width: 2,
//             style: BorderStyle.solid,
//             color: Pallets.white.withOpacity(0.5),
//           ),
//           borderRadius: BorderRadius.circular(150),
//         ),
//         shadows: const [
//           BoxShadow(
//             color: Pallets.primary,
//             blurRadius: 0,
//             offset: Offset(0, 0),
//             spreadRadius: 1,
//           ),
//           BoxShadow(
//             color: Pallets.primary,
//             blurRadius: 30,
//             blurStyle: BlurStyle.inner,
//             offset: Offset(0, 1),
//             spreadRadius: 0,
//           )
//         ],
//       ),
//       child:   Row(
//         children: [
//           const Text(
//             'Button',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Color(0xFFF2F2EF),
//               fontSize: 14,
//               fontFamily: 'Plus Jakarta Sans',
//               fontWeight: FontWeight.w600,
//
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
