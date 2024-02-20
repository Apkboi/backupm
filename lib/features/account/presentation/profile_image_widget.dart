import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/utils/string_extension.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';

class ProfileImageWidget extends StatefulWidget {
  ProfileImageWidget(
      {super.key,
      this.width = 24,
      this.height = 24,
      this.fit,
      this.shape,
      this.bgColor,
      this.border,
      this.borderRadius,
      this.size,
      this.color,
      this.imageUrl});

  final String? imageUrl;
  final double height;
  final double width;
  final BoxFit? fit;
  final BoxShape? shape;
  final Color? bgColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final double? size;
  final Color? color;

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: _listenToUserBloc,
      bloc: injector.get(),
      builder: (context, state) {
        return CachedNetworkImage(
          imageUrl: widget.imageUrl ?? injector.get<UserBloc>().appUser!.avatar,
          imageBuilder: (context, imageProvider) => Container(
            width: widget.size ?? widget.width,
            height: widget.size ?? widget.height,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              color: widget.bgColor ??
                  (injector.get<UserBloc>().appUser?.avatarBackgroundColor !=
                          null
                      ? injector
                              .get<UserBloc>()
                              .appUser
                              ?.avatarBackgroundColor
                              .toString()
                              .toColor() ??
                          Colors.orange
                      : Colors.orange),
              shape: widget.shape ?? BoxShape.circle,
              border: widget.border,
              image: DecorationImage(
                  image: imageProvider,
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  onError: (error, trace) {
                    logger.e(trace);
                  }),
            ),
          ),
          placeholder: (context, url) => _ErrorWidget(),
          errorWidget: (context, url, error) {
            return _ErrorWidget();
          },
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
            image: const AssetImage('Assets.pngsLogoMain'),
            fit: BoxFit.cover,
            onError: (error, trace) {
              // logger.e(trace);
            }),
      ),
    );
  }

  void _listenToUserBloc(BuildContext context, UserState state) {
    // setState(() {});
  }
}
