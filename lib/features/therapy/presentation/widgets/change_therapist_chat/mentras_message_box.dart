import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/change_therapist_message_model.dart';
import 'package:mentra/gen/assets.gen.dart';

class MentrasMessageBox extends StatefulWidget {
  const MentrasMessageBox({
    super.key,
    required this.message,
    this.child,
  });

  final ChangeTherapistMessageModel message;
  final Widget? child;

  @override
  State<MentrasMessageBox> createState() => _MentrasMessageBoxState();
}

class _MentrasMessageBoxState extends State<MentrasMessageBox> {
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
              child: ImageWidget(
                imageUrl: Assets.images.pngs.smallMentra.path,
                fit: BoxFit.cover,
                size: 40,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.message.message.length,
                (index) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2 + 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // borderRadius: BorderRadius.only(
                      //     bottomLeft: index.isEven
                      //         ? Radius.zero
                      //         : const Radius.circular(15),
                      //     topRight: const Radius.circular(15),
                      //     bottomRight: const Radius.circular(15),
                      //     topLeft: !index.isEven
                      //         ? Radius.zero
                      //         : const Radius.circular(15)
                      // ),
                      color: Pallets.navy),
                  child: Text(
                    widget.message.message.toList()[index],
                    style: const TextStyle(color: Pallets.white),
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
