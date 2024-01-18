import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentra/core/di/injector.dart';
import 'image_previewer.dart';

class ImageWidget extends StatefulWidget {
  final double height;
  final double width;
  final BoxFit? fit;
  final BoxShape? shape;
  final String imageUrl;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final double? size;
  final Color? color;
  final VoidCallback? onTap;
  final bool? canPreview;

  final ImageWidgetType imageType;

  const ImageWidget({
    Key? key,
    this.width = 24,
    this.height = 24,
    this.fit,
    this.shape,
    this.color,
    this.size,
    this.border,
    this.borderRadius,
    required this.imageUrl,
    this.imageType = ImageWidgetType.asset,
    this.canPreview = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.imageUrl.split('.').lastOrNull == 'svg') {
          return SvgPicture.asset(
            widget.imageUrl,
            width: widget.size,
            height: widget.size,
            color: widget.color,
            fit: widget.fit ?? BoxFit.contain,
          );
        }
        if ((widget.imageUrl.split('.').firstOrNull?.contains('http') ==
                true) ||
            widget.imageUrl == '' ||
            widget.imageType == ImageWidgetType.network) {
          if (widget.imageUrl == '') {
            return _ErrorWidget();
          }
          return InkWell(
            onTap: () {
              if (widget.canPreview!) {
                showDialog(
                  context: context,
                  builder: (context) => ImagePreviewer(
                    imageUrl: widget.imageUrl,
                    imageType: ImageType.network,
                  ),
                );
              }
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: widget.size ?? widget.width,
                height: widget.size ?? widget.height,
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  shape: widget.shape ?? BoxShape.rectangle,
                  border: widget.border,
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      onError: (error, trace) {
                        logger.e(trace);
                      }),
                ),
              ),
              placeholder: (context, url) => _ErrorWidget(),
              errorWidget: (context, url, error) {
                return _ErrorWidget();
              },
            ),
          );
        }
        return InkWell(
          onTap: () {
            if (widget.canPreview!) {
              showDialog(
                context: context,
                builder: (context) => ImagePreviewer(
                  imageUrl: widget.imageUrl,
                  imageType: ImageType.asset,
                ),
              );
            }
          },
          child: Container(
            key: widget.key,
            height: widget.size ?? widget.height,
            width: widget.size ?? widget.width,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              shape: widget.shape ?? BoxShape.rectangle,
              border: widget.border,
              image: widget.imageType == ImageWidgetType.asset
                  ? DecorationImage(
                      image: AssetImage(widget.imageUrl),
                      fit: widget.fit ?? BoxFit.cover,
                      onError: (error, trace) {
                        // logger.e(trace);
                      })
                  : DecorationImage(
                      image: FileImage(
                        File(widget.imageUrl),
                      ),
                      fit: widget.fit ?? BoxFit.cover,
                      onError: (error, trace) {
                        // logger.e(trace);
                      }),
            ),
          ),
        );
      },
    );
  }

  Container _ErrorWidget() {
    return Container(
      key: widget.key,
      height: widget.size ?? widget.height,
      width: widget.size ?? widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        shape: widget.shape ?? BoxShape.rectangle,
        border: widget.border,
        image: DecorationImage(
            image: AssetImage('Assets.pngsLogoMain'),
            fit: BoxFit.cover,
            onError: (error, trace) {
              // logger.e(trace);
            }),
      ),
    );
  }
}

enum ImageWidgetType { asset, network, file }
