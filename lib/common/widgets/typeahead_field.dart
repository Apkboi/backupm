import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'text_view.dart';

class CustomTypeAheadField extends StatefulWidget {
  const CustomTypeAheadField({
    Key? key,
    required this.controller,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    this.onSaved,
    this.hint = 'Country',
    this.validator,
    this.focusNode,
    this.hasLabel = true,
    this.duration,
  }) : super(key: key);
  final TextEditingController controller;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final void Function(dynamic) onSuggestionSelected;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? hint;
  final bool hasLabel;
  final FocusNode? focusNode;
  final Duration? duration;

  @override
  State<CustomTypeAheadField> createState() => _CustomTypeAheadFieldState();
}

class _CustomTypeAheadFieldState extends State<CustomTypeAheadField> {
  final String label = 'Country';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.hasLabel)
          TextView(
            text: label ?? '',
            fontSize: 14,
            color: Pallets.primaryDark,
          ),
        if (widget.hasLabel) 8.verticalSpace,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Pallets.grey50,
          ),
          child: TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              focusNode: widget.focusNode,
              controller: widget.controller,
              style: const TextStyle(color: Pallets.primary),
              decoration: InputDecoration(
                fillColor: Pallets.white,
                hintText: widget.hint,

                hintStyle: const TextStyle(
                  color: Pallets.hintGrey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                // errorStyle: TextStyle(fontSize: 10),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Pallets.borderGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                // focusedErrorBorder: OutlineInputBorder(
                //   borderSide: BorderSide.none,
                // ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Pallets.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),

                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Pallets.borderGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Pallets.borderGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            suggestionsCallback: widget.suggestionsCallback,
            itemBuilder: widget.itemBuilder,

            // hideOnEmpty: true,
            // hideOnLoading: true,

            transitionBuilder: (context, suggestionsBox, animationController) =>
                suggestionsBox,
            onSuggestionSelected: widget.onSuggestionSelected,
            validator: widget.validator,
            onSaved: widget.onSaved,
          ),
        ),
      ],
    );
  }
}
