import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class BCUserMessageWidget extends StatefulWidget {
  const BCUserMessageWidget({
    Key? key,
    required this.message,
    this.child,
  }) : super(key: key);
  final dynamic message;
  final Widget? child;

  @override
  State<BCUserMessageWidget> createState() => _BCUserMessageWidgetState();
}

class _BCUserMessageWidgetState extends State<BCUserMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2 + 40),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Pallets.userChatBg),
          child: widget.child ??
              Text(
                widget.message[0],
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Pallets.black,
                    fontWeight: FontWeight.w500),
              ),
        ),
        2.5.verticalSpace
      ],
    );
  }
}
