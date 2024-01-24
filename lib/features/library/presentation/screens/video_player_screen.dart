import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: '',
        actions: [
          const CircleAvatar(
            backgroundColor: Pallets.white,
            child: Icon(
              Icons.favorite_border,
              color: Pallets.black,
              size: 18,
            ),
          ),
          10.horizontalSpace,
        ],
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.videoThumbail.path,
          ),
          const Column(
            children: [Spacer(), VideoControllerWidget()],
          ),
        ],
      ),
    );
  }
}

class VideoControllerWidget extends StatelessWidget {
  const VideoControllerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: ImageWidget(imageUrl: Assets.images.svgs.backward15)),
            50.horizontalSpace,
            CircleAvatar(
              radius: 50,
              backgroundColor: Pallets.white.withOpacity(0.2),
              child: const CircleAvatar(
                backgroundColor: Pallets.white,
                radius: 40,
                child: Center(
                  child: Icon(
                    Icons.pause_rounded,
                    size: 30,
                    color: Pallets.black,
                  ),
                ),
              ),
            ),
            50.horizontalSpace,
            IconButton(
                onPressed: () {},
                icon: ImageWidget(imageUrl: Assets.images.svgs.forward)),
          ],
        ),
        55.verticalSpace,
        SliderTheme(
          data: const SliderThemeData(trackHeight: 1.7),
          child: Slider(
            activeColor: Pallets.white,
            thumbColor: Pallets.indigo100,
            inactiveColor: Pallets.trackColor,
            value: 0.2,
            onChanged: (value) {},
          ),
        ),
        5.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: '01:30',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Pallets.white),
              ),
              TextView(
                text: '01:30',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Pallets.white),
              )
            ],
          ),
        ),
        21.verticalSpace,
      ],
    );
  }
}
