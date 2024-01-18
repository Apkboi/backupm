import 'package:flutter/material.dart';
import 'package:mentra/core/theme/pallets.dart';

class UserMessageItem extends StatefulWidget {
  const UserMessageItem({
    Key? key,
    required this.message,
    this.child,
  }) : super(key: key);
  final dynamic message;
  final Widget? child;

  @override
  State<UserMessageItem> createState() => _UserMessageItemState();
}

class _UserMessageItemState extends State<UserMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2 + 40),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Pallets.navy),
          child: widget.child ??
              Text(
                widget.message[0],
                style: const TextStyle(fontSize: 14,color: Pallets.white),
              ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}