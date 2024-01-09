import 'package:flutter/material.dart';

import 'package:mentra/core/theme/pallets.dart';

class DropdownFieldButton extends StatefulWidget {
  const DropdownFieldButton(
      {Key? key,
      required this.hint,
      required this.onTap,
      this.val,
      required this.preffix})
      : super(key: key);
  final String hint;
  final String? val;
  final VoidCallback onTap;
  final Icon preffix;

  @override
  State<DropdownFieldButton> createState() => _DropdownFieldButtonState();
}

class _DropdownFieldButtonState extends State<DropdownFieldButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Pallets.grey.withOpacity(0.3)),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            IconTheme(
                data: const IconThemeData(color: Colors.grey),
                child: widget.preffix),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                (widget.val != null && widget.val!.isNotEmpty)
                    ? widget.val!
                    : widget.hint,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
