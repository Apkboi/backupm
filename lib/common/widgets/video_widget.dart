import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoWidget extends StatefulWidget {
  final String videoPath;
  final VideoSourceType videoType;
  final double height;
  final double width;

  VideoWidget(
      {required this.videoPath,
      required this.videoType,
      required this.height,
      required this.width});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

enum VideoSourceType {
  local,
  network,
}

class _VideoWidgetState extends State<VideoWidget> {
  final _thumbmnailKey = GlobalKey();
  late final Future<String?> thumbnailData;

  @override
  void initState() {
    super.initState();

    thumbnailData = _thumbnailData();
  }

  Future<String?> _thumbnailData() async {
    try {
      return VideoThumbnail.thumbnailFile(
        video: widget.videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxWidth: 300,
        maxHeight: 300,
        quality: 100,
      );
    } catch (e) {
      log("Wahala: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          FutureBuilder<String?>(
              key: _thumbmnailKey,
              future: thumbnailData,
              builder: (context, snapshot) {
                // log(widget.media.mediaPath);
                if (!snapshot.hasError) {
                  if (snapshot.hasData) {
                    return Stack(children: [
                      Stack(
                        children: [
                          Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            filterQuality: FilterQuality.high,
                          ),
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Pallets.black.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ]);
                  } else {
                    return Container(
                        color: Pallets.black,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Pallets.white,
                        )));
                  }
                } else {
                  return Text(snapshot.error.toString());
                }
              }),
          Center(
            child: GestureDetector(
              onTap: () => _openFullScreenDialog(context),
              child: const Icon(
                Icons.play_arrow,
                size: 35.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FullScreenVideoDialog(
            videoPath: widget.videoPath, videoType: VideoSourceType.network);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
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
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
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
