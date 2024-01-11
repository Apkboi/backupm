import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.actions,
      this.leading,
      this.tittle,
      this.tittleText,
      this.onBackPressed,
      this.elevation,
      this.bgColor,
      this.fgColor,
      this.height,
      this.canGoBack = true});

  final List<Widget>? actions;
  final Widget? leading;
  final Widget? tittle;
  final String? tittleText;
  final double? elevation;
  final VoidCallback? onBackPressed;
  final Color? bgColor;
  final Color? fgColor;
  final double? height;
  final bool? canGoBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      elevation: elevation ?? 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Theme.of(context).colorScheme.onBackground),
      leading: canGoBack!
          ? IconButton(
              onPressed: () {
                onBackPressed != null ? onBackPressed!() : context.pop(context);
              },
              icon: leading ??
                  Icon(
                    Iconsax.arrow_left_2,
                    color:
                        fgColor ?? Theme.of(context).colorScheme.onBackground,
                  ),
            )
          : null,
      title: tittle ??
          TextView(
            text: tittleText ?? 'My Appbar',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            style: GoogleFonts.plusJakartaSans(
                // fontSize: 16,
                color: fgColor),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
