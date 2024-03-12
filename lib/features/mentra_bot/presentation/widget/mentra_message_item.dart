import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class MentraMessageItem extends StatefulWidget {
  const MentraMessageItem({
    Key? key,
    required this.message,
    this.child,
  }) : super(key: key);
  final List<dynamic> message;
  final Widget? child;

  @override
  State<MentraMessageItem> createState() => _MentraMessageItemState();
}

class _MentraMessageItemState extends State<MentraMessageItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    logger.i('forwading');


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 2), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 36.h, right: 10),
                  child: CircleAvatar(
                    backgroundColor: Pallets.lighterBlue,
                    child: ImageWidget(
                      imageUrl: Assets.images.pngs.mentraBig.path,
                      fit: BoxFit.cover,
                      size: 40,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.message.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2 + 40),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // borderRadius: BorderRadius.only(
                          //     bottomLeft: index.isEven
                          //         ? Radius.zero
                          //         : const Radius.circular(15),
                          //     topRight: const Radius.circular(15),
                          //     bottomRight: const Radius.circular(15),
                          //     topLeft: !index.isEven
                          //         ? Radius.zero
                          //         : const Radius.circular(15)
                          // ),
                          color: Pallets.primary),
                      child: Text(
                        widget.message.reversed.toList()[index],
                        style: TextStyle(color: Pallets.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
