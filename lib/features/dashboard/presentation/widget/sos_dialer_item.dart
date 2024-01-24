import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

class SosDialerItem extends StatelessWidget {
  const SosDialerItem(
      {super.key,
      required this.icon,
      required this.tittle,
      required this.subtittle,
      required this.onTap,
      this.iconBg});

  final String icon;
  final String tittle;
  final String subtittle;
  final VoidCallback onTap;
  final Color? iconBg;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
        radius: 50,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: (iconBg??Pallets.skyBlue).withOpacity(0.4),
                radius: 24,
                child: Center(child: Text(icon)),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(text: tittle),
                    TextView(
                      text: subtittle,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Pallets.red,
                child: Center(
                    child: Icon(
                  Icons.phone_rounded,
                  color: Pallets.white,
                )),
              ),
            ],
          ),
        ));
  }
}
