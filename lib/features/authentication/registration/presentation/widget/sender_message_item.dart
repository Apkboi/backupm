import 'package:flutter/material.dart';
import 'package:mentra/core/theme/pallets.dart';

class SenderMessageItem extends StatefulWidget {
  const SenderMessageItem({
    Key? key,
    required this.message,
    this.child,
  }) : super(key: key);
  final dynamic message;
  final Widget? child;

  @override
  State<SenderMessageItem> createState() => _SenderMessageItemState();
}

class _SenderMessageItemState extends State<SenderMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2 + 40),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Pallets.white),
          child: widget.child ??
              Text(
                widget.message,
                style: const TextStyle( fontSize: 14),
              ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
