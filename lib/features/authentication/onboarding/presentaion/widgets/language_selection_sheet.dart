import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_search_bar.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.5.sh),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Pallets.bgLight,
        appBar: const CustomAppBar(
          bgColor: Pallets.bgLight,
          leading: Icon(
            Icons.close,
            color: Pallets.black,
          ),
          tittleText: 'App language',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSearchBar(
                tittle: 'Search',
              ),
              30.verticalSpace,
              HapticInkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const TextView(text: 'English')),
              const Spacer(),
              Center(
                child: CustomNeumorphicButton(
                  onTap: () {},
                  color: Pallets.secondary,
                  fgColor: Pallets.black,
                  text: "Save",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
