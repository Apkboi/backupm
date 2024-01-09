import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';

import 'package:mentra/core/theme/pallets.dart';

class TextBoxField extends StatefulWidget {
  final String? label;
  final int? maxLines;
  final int? minLines;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyBoardType;
  final bool hasBottomPadding;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final bool hasLabel;
  final Color? fillColor;

  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextAlign? textAlign;

  final bool isPasswordField;
  final bool isPhoneField;
  final bool topLabel;
  final AutovalidateMode? autoValidate;
  final void Function(String)? onSubmit;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final void Function(String)? onValueChnaged;
  final List<TextInputFormatter>? inputFormatter;

  const TextBoxField({
    Key? key,
    this.label,
    this.prefix,
    this.suffix,
    this.isEnabled = true,
    this.hasLabel = true,
    this.topLabel = false,
    // this.isTextObscured = false,
    required this.controller,
    this.hintText,
    this.keyBoardType = TextInputType.text,
    this.hasBottomPadding = true,
    this.validator,
    this.isPasswordField = false,
    this.isPhoneField = false,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onSubmit,
    this.onTap,
    this.onValueChnaged,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatter,
    this.autoValidate,
    this.fillColor,
    this.textAlign,
  }) : super(key: key);

  @override
  State<TextBoxField> createState() => _TextBoxFieldState();
}

class _TextBoxFieldState extends State<TextBoxField> {
  bool onChanged = false;
  bool showPasswordText = false;
  bool showIcon = false;
  bool isTextObscured = true;

  final ValueNotifier<bool> isEmpty = ValueNotifier(true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.text.isEmpty) {
        isEmpty.value = true;
      } else {
        isEmpty.value = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(builder: (context) {
          if (widget.topLabel)
            return Column(
              children: [
                TextView(
                  text: widget.label ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.maybeBlack,
                ),
                8.verticalSpace,
              ],
            );
          return SizedBox();
        }),
        // if (widget.hasLabel)
        //   TextView(
        //     text: widget.label ?? widget.hintText ?? '',
        //     fontSize: 14,
        //     color: Pallets.primaryDark,
        //   ),
        // if (widget.hasLabel) 8.verticalSpace,
        Padding(
          padding: widget.hasBottomPadding
              ? EdgeInsets.only(top: 0, bottom: 24.h)
              : const EdgeInsets.only(top: 0, bottom: 0),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            // autofocus: true,
            style: TextStyle(
                color: Pallets.black,
                fontSize:
                    (widget.isPasswordField && isTextObscured) ? 12.sp : 16.sp),
            autovalidateMode: widget.autoValidate,

            maxLines: widget.maxLines,

            onChanged: (value) {
              if (widget.onValueChnaged != null) {
                super.widget.onValueChnaged!(value);
              }
            },
            textAlign: widget.textAlign ?? TextAlign.start,
            enabled: widget.isEnabled,
            validator: widget.validator,

            onFieldSubmitted: widget.onSubmit,

            onTap: widget.onTap,
            focusNode: widget.focusNode,
            keyboardType: widget.isPhoneField
                ? TextInputType.number
                : widget.keyBoardType,
            controller: widget.controller,
            obscureText: widget.isPasswordField && isTextObscured,
            obscuringCharacter: '⬤',

            minLines: widget.minLines,
            cursorColor: Pallets.primary,
            inputFormatters: !widget.isPhoneField
                ? widget.inputFormatter
                : [LengthLimitingTextInputFormatter(11)],
            cursorWidth: 1.5,
            decoration: InputDecoration(
              filled: true,
              label: widget.topLabel
                  ? null
                  : TextView(
                      text: widget.label ?? '',
                    ),
              alignLabelWithHint: true,
              floatingLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Pallets.primaryDark,
              ),
              fillColor: widget.fillColor ?? Colors.white,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),

              errorMaxLines: 1,

              hintText: widget.hintText ?? widget.label,
              // constraints: BoxConstraints(maxHeight: 60, minHeight: 40),
              prefixIcon: widget.prefixIcon,

              prefix: widget.prefix,

              suffix: widget.suffix,
              suffixIcon: widget.isPasswordField
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextObscured = !isTextObscured;
                          // widget.errorText = null;
                        });
                      },
                      child: Icon(
                        isTextObscured
                            ? CupertinoIcons.eye_slash
                            : Icons.remove_red_eye_outlined,
                        size: 24.0,
                        color: Pallets.grey,
                      ),
                    )
                  : widget.suffixIcon,
              hintStyle: TextStyle(
                color: Pallets.borderGrey,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.karla().fontFamily,
              ),
              // errorStyle: TextStyle(fontSize: 10),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Pallets.primary,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              // disabledBorder: const OutlineInputBorder(
              //   borderSide: BorderSide.none,
              //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // ),

              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Pallets.borderGrey),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Pallets.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),

              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color:
                      widget.isEnabled ? Pallets.borderGrey : Pallets.primary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color:
                      widget.isEnabled ? Pallets.borderGrey : Pallets.primary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
