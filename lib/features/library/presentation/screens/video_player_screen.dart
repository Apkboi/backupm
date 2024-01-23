import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
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
          AppBg(image: Assets.images.pngs.videoThumbail.path,),
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
          children: [
            IconButton(
                onPressed: () {},
                icon: ImageWidget(imageUrl: Assets.images.svgs.backward15))
          ],
        )
      ],
    );
  }
}
