import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raycon_app/common/widgets/image_widget.dart';
import 'package:raycon_app/core/constants/package_exports.dart';
import 'package:raycon_app/core/theme/pallets.dart';
import 'package:raycon_app/gen/assets.gen.dart';

class ReceiverMessageItem extends StatefulWidget {
  const ReceiverMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);
  final dynamic message;

  @override
  State<ReceiverMessageItem> createState() => _ReceiverMessageItemState();
}

class _ReceiverMessageItemState extends State<ReceiverMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 36.h,right: 10),
              child: ImageWidget(imageUrl: Assets.images.svgs.logoSecondary,size: 36,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                 Text(
                  "Raycon",
                  style: GoogleFonts.sora(color: Pallets.grey60, fontSize: 16),
                ),
                16.verticalSpace,

                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2 + 40),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Pallets.surfaceDark),
                  child: Text(
                    widget.message,
                    style: TextStyle(color: Pallets.white),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "12:01 PM",
                  style: TextStyle(color: Pallets.grey60, fontSize: 12),
                )
              ],
            ),
          ],
        ),

      ],
    );
  }
}
