import 'package:flutter/material.dart';
import 'package:mentra/core/theme/pallets.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({super.key, this.icon});

  final Widget? icon;

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: CircleAvatar(
        backgroundColor: Pallets.grey90,
        foregroundColor: Pallets.grey,
        radius: 23,
        child: Center(
          child: widget.icon ?? const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
