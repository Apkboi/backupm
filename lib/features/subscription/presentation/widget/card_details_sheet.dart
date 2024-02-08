import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class CardDetailsSheet extends StatefulWidget {
  const CardDetailsSheet({super.key});

  @override
  State<CardDetailsSheet> createState() => _CardDetailsSheetState();
}

class _CardDetailsSheetState extends State<CardDetailsSheet> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Pallets.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            16.verticalSpace,
            TextView(
              text: 'Enter Card Details',
              style: GoogleFonts.fraunces(
                  fontSize: 20.sp,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w600),
            ),
            16.verticalSpace,
            FilledTextField(
              hint: 'Card Name',
              hasBorder: true,
              validator:
                  RequiredValidator(errorText: 'Enter your card expiry date')
                      .call,
            ),
            16.verticalSpace,
            FilledTextField(
              hint: 'Card Number',
              inputType: TextInputType.number,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Enter your card number'),
                RangeValidator(
                    min: 16, max: 16, errorText: 'Card Number should 16 digits')
              ]).call,
              hasBorder: true,
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: FilledTextField(
                  validator: RequiredValidator(
                          errorText: 'Enter your card expiry date')
                      .call,
                  hint: 'Expiry Date (02/2024)',
                )),
                16.horizontalSpace,
                Expanded(
                    child: FilledTextField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Enter your card CVV'),
                    RangeValidator(
                        min: 3,
                        max: 3,
                        errorText: 'Card Cvv should exactly 3 digits')
                  ]).call,
                  hint: 'Cvv',
                  inputType: TextInputType.number,
                )),
              ],
            ),
            30.verticalSpace,
            CustomNeumorphicButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.pop();
                }
              },
              color: Pallets.primary,
              text: 'Proceed',
            )
          ],
        ),
      ),
    );
  }
}
