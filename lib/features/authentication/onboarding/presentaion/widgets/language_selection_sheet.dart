import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_search_bar.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/theme/pallets.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [
            const CustomSearchBar(
              tittle: 'Search',
            ),
            Expanded(child: Container()),
            CustomNeumorphicButton(
              onTap: () {},
              color: Pallets.secondary,
              fgColor: Pallets.black,
              text: "Save",
            )
          ],
        ),
      ),
    );
  }
}
