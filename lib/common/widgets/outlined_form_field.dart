import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class OutlinedFormField extends StatefulWidget {
  const OutlinedFormField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.maxLine,
      this.inputType,
      this.obscure,
      this.controller,
      this.onChange,
      this.onFieldSubmitted,
      this.enabled,
      this.inputFormatters,
      this.placeHolder,
      this.isRequired = true})
      : super(key: key);
  final String hint;
  final String? placeHolder;
  final bool? isRequired;
  final bool? obscure;
  final Widget? suffix;
  final Widget? preffix;
  final int? maxLine;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String d)? onChange;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<OutlinedFormField> createState() => _OutlinedFormFieldState();
}

class _OutlinedFormFieldState extends State<OutlinedFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          if (widget.placeHolder != null)
            Row(
              children: [
                TextView(
                  text: widget.placeHolder!,
                  style: GoogleFonts.sora(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                if (widget.isRequired!)
                  const TextView(
                    text: " *",
                    color: Pallets.error,
                  ),
              ],
            ),
          8.verticalSpace,
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            maxLines: widget.maxLine ?? 1,
            onChanged: widget.onChange,
            keyboardType: widget.inputType,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obscure == null ? false : widget.obscure!,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14.sp),
            decoration: InputDecoration(
                filled: false,
                focusedBorder: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide:
                        const BorderSide(color: Pallets.grey75, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                fillColor: Theme.of(context).cardColor,
                hintText: widget.hint,
                suffixIcon: widget.suffix,
                prefixIcon: widget.preffix,
                iconColor: Colors.grey,
                enabled: widget.enabled ?? true,
                prefixIconColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide:
                        const BorderSide(color: Pallets.grey90, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                suffixIconColor: Pallets.grey75,
                hintStyle: TextStyle(color: Pallets.grey60, fontSize: 13.sp)),
          ),
        ],
      ),
    );
  }
}
