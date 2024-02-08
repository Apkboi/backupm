import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/subscription/data/models/card_details_payload.dart';

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

  late final RegExp _expiryDateRegex;

  void _formatExpiryDate() {
    final originalText = _expiryDateController.text;
    if (originalText.length == 2) {
      _expiryDateController.text = "$originalText/";
    }

    // if (_expiryDateController.text != formattedText) {
    //   _expiryDateController.value = TextEditingValue(
    //     text: formattedText,
    //     selection: TextSelection.collapsed(offset: formattedText.length),
    //   );
    // }
  }

  @override
  void initState() {
    _expiryDateRegex = RegExp(r'^([0-9]{0,2})/?([0-9]{0,2})$');
    _expiryDateController.addListener(_formatExpiryDate);
    super.initState();
  }

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
              hasElevation: false,
              hint: 'Card Name',
              controller: _nameController,
              hasBorder: true,
              validator:
                  RequiredValidator(errorText: 'Enter your card expiry date')
                      .call,
            ),
            16.verticalSpace,
            FilledTextField(
              hasElevation: false,
              hint: 'Card Number',
              inputType: TextInputType.number,
              controller: _numberController,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Enter your card number'),
                LengthRangeValidator(
                    min: 16, max: 16, errorText: 'Card Number should 16 digits')
              ]).call,
              hasBorder: true,
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: FilledTextField(
                  hasElevation: false,
                  controller: _expiryDateController,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    LengthLimitingTextInputFormatter(5),
                  ],
                  validator: MultiValidator([
                    LengthRangeValidator(
                        min: 5, max: 5, errorText: 'Invalid Expiry date '),
                    RequiredValidator(errorText: 'Enter your card expiry date'),
                  ]).call,
                  hint: 'Expiry Date',
                )),
                16.horizontalSpace,
                Expanded(
                    child: FilledTextField(
                  hasElevation: false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Enter your card CVV'),
                    LengthRangeValidator(
                        min: 3,
                        max: 3,
                        errorText: 'Card Cvv should exactly 3 digits')
                  ]).call,
                  hint: 'Cvv',
                  controller: _cvvController,
                  inputType: TextInputType.number,
                )),
              ],
            ),
            30.verticalSpace,
            CustomNeumorphicButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  SubscriptionCard card = SubscriptionCard(
                      cardCvc: 123,
                      cardExpMonth: 12,
                      cardExpYear: 36,
                      cardNumber: _numberController.text,
                      cardOwnerName: _nameController.text);
                  context.pop(card);
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
