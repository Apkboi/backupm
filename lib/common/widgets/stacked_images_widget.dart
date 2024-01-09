import 'package:flutter/material.dart';

class StackedImagesWidget extends StatefulWidget {
  const StackedImagesWidget({Key? key}) : super(key: key);

  @override
  State<StackedImagesWidget> createState() => _StackedImagesWidgetState();
}

class _StackedImagesWidgetState extends State<StackedImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(4, (index) => Positioned(
          right: (7*index).toDouble(),
          child:  CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue.withOpacity(0.2*index),
          ),
        )),
      ),
    );
  }
}
