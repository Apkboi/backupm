import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';
import 'package:mentra/gen/assets.gen.dart';

class SettingsGroup2 extends StatelessWidget {
  const SettingsGroup2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
          text: 'Join our community',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Pallets.primary,
        ),
        16.verticalSpace,
        GlassContainer(
            child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              SettingListTile(
                leadingIconUrl: Assets.images.svgs.facebook,
                tittle: 'Find us on Facebook',
                hasArrow: false,
              ),
              24.verticalSpace,
              SettingListTile(
                leadingIconUrl: Assets.images.svgs.instagram,
                tittle: 'Connect with us on Instagram',
                hasArrow: false,
              ),
              24.verticalSpace,
              SettingListTile(
                leadingIconUrl: Assets.images.svgs.twitter,
                tittle: 'Follow us on X',
                hasArrow: false,
              ),
              24.verticalSpace,
              SettingListTile(
                leadingIconUrl: Assets.images.svgs.tiktox,
                tittle: 'Connect with us on Tiktok',
                hasArrow: false,
              ),
            ],
          ),
        )),
      ],
    );
  }
}
