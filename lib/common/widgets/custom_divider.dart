import 'package:flutter/material.dart';

import '../../core/theme/pallets.dart';



class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(color: Pallets.borderGrey.withOpacity(0.5)),
    );
  }
}
