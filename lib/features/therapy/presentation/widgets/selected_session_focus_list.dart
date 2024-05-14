import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/text_view.dart';

class SelectedSessionFocusChipList extends StatefulWidget {
  final List<String> selectedSessionFocuses;
  final Function(List<String>) onSelectedFocusChange;


  const SelectedSessionFocusChipList({
    super.key,
    required this.selectedSessionFocuses,
    required this.onSelectedFocusChange,
  });

  @override
  State<SelectedSessionFocusChipList> createState() =>
      _SelectedSessionFocusChipListState();
}

class _SelectedSessionFocusChipListState
    extends State<SelectedSessionFocusChipList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: widget.selectedSessionFocuses.isEmpty
          ? [
              const TextView(text: 'Select session focus'),
            ]
          : widget.selectedSessionFocuses
              .map((focus) => Chip(
                    label: Text(focus),
                    backgroundColor: Colors.grey.shade200,
                    onDeleted: () => setState(() {
                      widget.selectedSessionFocuses.remove(focus);
                      widget
                          .onSelectedFocusChange(widget.selectedSessionFocuses);
                    }),
                  ))
              .toList(), // Adjust spacing between chips
    );
  }
}


class ViewSessionFocusChipList extends StatefulWidget {
  final List<String> selectedSessionFocuses;



  const ViewSessionFocusChipList({
    super.key,
    required this.selectedSessionFocuses,

  });

  @override
  State<ViewSessionFocusChipList> createState() =>
      _ViewSessionFocusChipListState();
}

class _ViewSessionFocusChipListState
    extends State<ViewSessionFocusChipList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: widget.selectedSessionFocuses.isEmpty
          ? [
        const TextView(text: 'No'),
      ]
          : widget.selectedSessionFocuses
          .map((focus) => Chip(
        label: Text(focus),
        backgroundColor: Colors.grey.shade200,

      ))
          .toList(), // Adjust spacing between chips
    );
  }
}
