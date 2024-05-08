import 'package:flutter/material.dart';
import 'package:mentra/core/theme/pallets.dart';

class IncomingCallAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final Widget icon;
  final VoidCallback onTap;

  const IncomingCallAnimation({super.key,
    this.size = 100.0,
    this.color = Colors.green,
    required this.icon, required this.onTap});

  @override
  _IncomingCallAnimationState createState() => _IncomingCallAnimationState();
}

class _IncomingCallAnimationState extends State<IncomingCallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.repeat(reverse: false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onTap,
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: widget.size + (widget.size * _animation.value),
              height: widget.size + (widget.size * _animation.value),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(1.0 - _animation.value),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: widget.color,
                  radius: widget.size * 0.5,
                  child: widget.icon,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
