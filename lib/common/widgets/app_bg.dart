import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class AppBg extends StatelessWidget {
  const AppBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        ImageWidget(
          imageUrl: Assets.images.svgs.background,
          height: 1.sh,
          fit: BoxFit.cover,
          width: 1.sw,
        ),
        Container(
          height: 1.sh,
          width: 1.sw,
          color: Pallets.white.withOpacity(0.4),
        )
      ],
    );
  }
}
