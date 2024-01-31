import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';

class SettingsGroup3 extends StatelessWidget {
  const SettingsGroup3({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
        child: Padding(
      padding: const EdgeInsets.all(17),
      child: Column(
        children: [
          SettingListTile(
            tittle: 'Delete Account',
            onTap: () {
              context.pushNamed(PageUrl.deleteAccountScreen);
            },
          ),
          24.verticalSpace,
          const SettingListTile(tittle: 'Privacy Policy'),
          24.verticalSpace,
          const SettingListTile(tittle: 'Terms and Conditions'),
        ],
      ),
    ));
  }
}
