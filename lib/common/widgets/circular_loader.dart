import 'package:flutter/material.dart';

class CircularLoader extends StatefulWidget {
  const CircularLoader({Key? key, this.color, this.size}) : super(key: key);
  final Color? color;
  final double? size;

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size ??20,
      width: widget.size ??20,
      child: CircularProgressIndicator(
        color: widget.color ?? Colors.white,
      ),
    );
  }
}
