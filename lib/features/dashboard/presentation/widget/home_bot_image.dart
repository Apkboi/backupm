import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/gen/assets.gen.dart';

class HomeBotImage extends StatefulWidget {
  const HomeBotImage({super.key});

  @override
  State<HomeBotImage> createState() => _HomeBotImageState();
}

class _HomeBotImageState extends State<HomeBotImage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Define animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Define animation
    _animation = Tween<double>(
      begin: 20,
      end: 0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Start animation
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: ImageWidget(
              imageUrl: Assets.images.pngs.mentra2.path,
              height: 250.h,
              width: 254,
              fit: BoxFit.contain,
            ),
          );
        });
  }
}
