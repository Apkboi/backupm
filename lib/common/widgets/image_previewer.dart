import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';



enum ImageType {
  asset,
  file,
  network,
}

class ImagePreviewer extends StatelessWidget {
  final String imageUrl;
  final bool? tightMode;
  final String? heroTag;
  final ImageType? imageType;

  ImagePreviewer({Key? key,
    required this.imageUrl,
    this.tightMode,
    this.heroTag,
    this.imageType = ImageType.network})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    // log('{imageUrl.replaceRange(0, 1,'')}');
    return Stack(
      fit: StackFit.expand,
      // alignment: Alignment.topLeft,
      children: [

        PhotoView(
          // backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          imageProvider: imageType == ImageType.asset
              ? AssetImage(imageUrl)
              : imageType == ImageType.file
              ? FileImage(File(imageUrl)) as ImageProvider
              : NetworkImage(imageUrl),
          heroAttributes: PhotoViewHeroAttributes(tag: heroTag ?? ""),
          basePosition: Alignment.center,
          tightMode: tightMode,
          errorBuilder: (context, object, stackTrace) =>
          const Center(
            child: Text('Error loading image'),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                )),
          ),
        ),
        // if (imageType! == ImageType.network)
        //   Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Padding(
        //       padding: const EdgeInsets.all(28.0),
        //       child: TextButton(
        //           style: TextButton.styleFrom(
        //               backgroundColor: Theme
        //                   .of(context)
        //                   .colorScheme
        //                   .primary,
        //               shape: StadiumBorder(),
        //               padding: EdgeInsets.all(16),
        //               foregroundColor: Colors.white),
        //           onPressed: () {
        //             // _downloadBloc.add(DownloadImageEvent(imageUrl));
        //           },
        //           child: Text('Download image')),
        //     ),
        //   )
      ],
    );
  }


}
