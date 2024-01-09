import 'package:flutter/material.dart';

class UserCircleImage extends StatefulWidget {
  const UserCircleImage(
      {Key? key, required this.url, this.size = const Size(60, 60)})
      : super(key: key);
  final String url;
  final Size? size;

  @override
  State<UserCircleImage> createState() => _UserCircleImageState();
}

class _UserCircleImageState extends State<UserCircleImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size?.height,
      width: widget.size?.width,
      decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(13),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: widget.url.isNotEmpty
                  ? NetworkImage(widget.url) as ImageProvider
                  : const AssetImage(
                      "assets/images/person.jpeg",
                    ))),
    );
  }
}
