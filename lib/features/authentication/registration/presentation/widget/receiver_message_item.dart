import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/gen/assets.gen.dart';

class ReceiverMessageItem extends StatefulWidget {
  const ReceiverMessageItem({
    Key? key,
    required this.message,
    this.child,
  }) : super(key: key);
  final List<dynamic> message;
  final Widget? child;

  @override
  State<ReceiverMessageItem> createState() => _ReceiverMessageItemState();
}

class _ReceiverMessageItemState extends State<ReceiverMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  margin: const EdgeInsets.only(bottom: 10),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2 + 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: index.isEven
                              ? Radius.zero
                              : const Radius.circular(15),
                          topRight: const Radius.circular(15),
                          bottomRight: const Radius.circular(15),
                          topLeft: !index.isEven
                              ? Radius.zero
                              : const Radius.circular(15)),
                      color: Pallets.navy),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.message.toList()[index],
                        style:  TextStyle(color: Pallets.white,fontSize: 15.sp),
                      ),
                      8.verticalSpace,
                      Text(TimeUtil.formatTime(DateTime.now()),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Pallets.white,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
