import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        Column(
          children: List.generate(
            widget.message.length,
            (index) => Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2 + 40),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Pallets.lightSecondary),
              child: widget.child ??
                  Text(
                    widget.message[index],
                    style: TextStyle(fontSize: 15.sp),
                  ),
            ),
          ),
        ),
        5.verticalSpace,
      ],
    );
  }
}
