import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/app_styles.dart';
import 'package:mentra/core/theme/pallets.dart';

class FilledTextField extends StatefulWidget {
  final String hint;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? preffix;
  final FocusNode? focusNode;
  final int? maxLine;
  final int? minLine;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? obscured;
  final bool? outline;
  final bool? autofocus;
  final bool? hasElevation;
  final bool? hasBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? textColor;
  final String? Function(String?)? validator;

  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final String? Function(String?)? onSaved;
  final GlobalKey<FormFieldState<dynamic>>? formKey;

  final double radius;
  final double? fontSize;
  final bool? expands;

  final List<TextInputFormatter>? inputFormatters;

  const FilledTextField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.maxLine,
      this.inputType,
      this.controller,
      this.onChanged,
      this.enabled,
      this.contentPadding,
      this.textInputAction,
      this.obscured = false,
      this.expands = false,
      this.fillColor,
      this.focusNode,
      this.outline = false,
      this.autofocus = false,
      this.hasElevation = true,
      this.formKey,
      this.minLine,
      this.onFieldSubmitted,
      this.onSaved,
      this.hasBorder = true,
      this.radius = 10,
      this.textColor,
      this.labelText,
      this.labelTextStyle,
      this.suffixIcon,
      this.inputFormatters,
      this.fontSize})
      : super(key: key);

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(

        textCapitalization: TextCapitalization.sentences,
        validator: widget.validator,
        key: widget.formKey,
        controller: widget.controller,
        maxLines: widget.expands! ? null : widget.maxLine ?? 1,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).colorScheme.onBackground,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        obscureText: widget.obscured!,
        focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatters,
        autofocus: widget.autofocus!,
        expands: widget.expands!,
        minLines: widget.expands! ? null : widget.minLine,
        textInputAction: widget.textInputAction,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color:
                widget.textColor ?? Theme.of(context).colorScheme.onBackground,
            fontSize: widget.fontSize ?? 16.sp,
            fontWeight: FontWeight.w500),
        decoration: AppStyles.filledTextFieldDecoration.copyWith(

            // alignLabelWithHint: true,
            constraints: widget.expands!
                ? const BoxConstraints(maxHeight: 20, minHeight: 40)
                : null,
            fillColor:
                widget.fillColor ?? Theme.of(context).colorScheme.surface,
            enabledBorder: widget.hasBorder!
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide:
                        BorderSide(color: Pallets.grey.withOpacity(0.2)))
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            hintText: widget.hint,
            suffixIcon: widget.suffix,
            // suffix: widget.suffix,
            focusedBorder: widget.outline!
                ? OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius))
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            border: widget.hasBorder!
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(color: Colors.transparent),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            prefixIcon: widget.preffix,
            prefixIconColor: Pallets.grey,
            suffixIconColor: Theme.of(context).colorScheme.primary,
            enabled: widget.enabled,
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(16),
            filled: true,

            // labelText: widget.labelText,
            // labelStyle: widget.labelTextStyle,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp)),
      ),
    );
  }
}
