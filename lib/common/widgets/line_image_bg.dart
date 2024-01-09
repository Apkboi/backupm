import 'package:flutter/material.dart';

class LineImageBackGround extends StatefulWidget {
  const LineImageBackGround({super.key, required this.child});

  final Widget child;

  @override
  State<LineImageBackGround> createState() => _LineImageBackGroundState();
}

class _LineImageBackGroundState extends State<LineImageBackGround> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/pngs/abstract_bg.png',
            fit: BoxFit.fitHeight,
            color: Colors.indigo.shade200.withOpacity(0.15),
            alignment: Alignment.center),
        widget.child],
    );
  }
}
