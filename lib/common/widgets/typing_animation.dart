import 'package:flutter/material.dart';

class TypingDotAnimation extends StatefulWidget {
  final Duration duration;
  final Color color;
  final double dotSize;
  final double spacing;

  const TypingDotAnimation({
    Key? key,
    this.duration = const Duration(seconds: 2),
    this.color = Colors.white,
    this.dotSize = 5,
    this.spacing = 3,
  }) : super(key: key);

  @override
  _TypingDotAnimationState createState() => _TypingDotAnimationState();
}

class _TypingDotAnimationState extends State<TypingDotAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Dot(
                animationValue: _controller.value,
                color: widget.color,
                size: widget.dotSize),
            SizedBox(width: widget.spacing),
            Dot(
                animationValue: _controller.value,
                color: widget.color,
                size: widget.dotSize),
            SizedBox(width: widget.spacing),
            Dot(
                animationValue: _controller.value - 0.00,
                color: widget.color,
                size: widget.dotSize),
            SizedBox(width: widget.spacing),
            Dot(
                animationValue: _controller.value - 0.000,
                color: widget.color,
                size: widget.dotSize),
            SizedBox(width: widget.spacing),
            Dot(
                animationValue: _controller.value - 0.007,
                color: widget.color,
                size: widget.dotSize),
          ],
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  final double animationValue;
  final Color color;
  final double size;

  const Dot({
    Key? key,
    required this.animationValue,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  double _calculateOpacity() {
    if (animationValue >= 0.75) {
      return (animationValue - 0.75) * 4; // Adjusted opacity calculation
    } else if (animationValue >= 0.25) {
      return 1.0;
    } else {
      return animationValue * 4;
    }
  }
}
