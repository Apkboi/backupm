import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';

class SettingsGroup1 extends StatelessWidget {
  const SettingsGroup1({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
        child: Padding(
      padding: const EdgeInsets.all(17),
      child: Column(
        children: [
          SettingListTile(
            tittle: 'Notifications',
            trailingWidget: CupertinoSwitch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          24.verticalSpace,
          SettingListTile(
            tittle: 'Security & privacy',
            onTap: () {
              context.pushNamed(PageUrl.securityPrivacyScreen);
            },
          ),
          24.verticalSpace,
          const SettingListTile(tittle: 'Preferences'),
          24.verticalSpace,
          const SettingListTile(tittle: 'Give feedback'),
          24.verticalSpace,
          const SettingListTile(tittle: 'Support'),
        ],
      ),
    ));
  }
}
