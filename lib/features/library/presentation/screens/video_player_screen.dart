import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/common/widgets/video_widget.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/features/library/presentation/widgets/favorite_acction_button.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.courseJson});

  final String courseJson;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late LibraryCourse course;

  // final libraryBloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    course = LibraryCourse.fromJson(jsonDecode(widget.courseJson));
    // libraryBloc.add(GetCourseDetailEvent(course.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: '',
        actions: [
          FavoriteActionButton(
            favourite: course.favourite,
            id: course.id.toString(),
          ),
          10.horizontalSpace,
        ],
      ),
      body: FullScreenVideoDialog(
          videoPath: course.attachments?.first.file.url ?? '',
          videoType: VideoSourceType.network),
    );
  }
}

class VideoControllerWidget extends StatefulWidget {
  const VideoControllerWidget({super.key, required this.controller});

  final ChewieController controller;

  @override
  State<VideoControllerWidget> createState() => _VideoControllerWidgetState();
}

class _VideoControllerWidgetState extends State<VideoControllerWidget> {
  @override
  void initState() {
    widget.controller.addListener(() {});
    super.initState();
  }

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
              child: InkWell(
                onTap: () {
                  widget.controller.isPlaying
                      ? widget.controller.play()
                      : widget.controller.pause();
                },
                child: CircleAvatar(
                  backgroundColor: Pallets.white,
                  radius: 40,
                  child: Center(
                    child: Icon(
                      widget.controller.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_outlined,
                      size: 30,
                      color: Pallets.black,
                    ),
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

class FullScreenVideoDialog extends StatefulWidget {
  final String videoPath;
  final VideoSourceType videoType;

  FullScreenVideoDialog({required this.videoPath, required this.videoType});

  @override
  _FullScreenVideoDialogState createState() => _FullScreenVideoDialogState();
}

class _FullScreenVideoDialogState extends State<FullScreenVideoDialog> {
  late ChewieController _chewieController;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    if (widget.videoType == VideoSourceType.local) {
      videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    } else {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
    }

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      // Adjust aspect ratio as needed
      autoInitialize: true,
      looping: false,
      autoPlay: true,
      draggableProgressBar: true,
      progressIndicatorDelay: const Duration(milliseconds: 300),

      // showControls: false,
      customControls: const CupertinoControls(
        showPlayButton: true,
        backgroundColor: Pallets.black,
        iconColor: Pallets.white,
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Full Screen Video'),
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Chewie(
            controller: _chewieController,
          ),
          const Column(
            children: [
              // Spacer(),
              // VideoControllerWidget(
              //   controller: _chewieController,
              // ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    videoPlayerController.dispose();

    super.dispose();
  }
}
