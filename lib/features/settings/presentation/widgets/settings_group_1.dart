import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';
import 'package:mentra/gen/assets.gen.dart';

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
            leadingIconUrl: Assets.images.svgs.bellFilled,
            tittle: 'Notifications',
            trailingWidget: CupertinoSwitch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          24.verticalSpace,
          SettingListTile(
            leadingIconUrl: Assets.images.svgs.lockOpen,
            tittle: 'Security & privacy',
            onTap: () {
              context.pushNamed(PageUrl.securityPrivacyScreen);
            },
          ),
          24.verticalSpace,
          SettingListTile(
              onTap: () {
                context
                    .pushNamed(PageUrl.userPreferenceScreen, queryParameters: {
                  PathParam.userPreferenceFlow: UserPreferenceFlow.updatePreference.name
                });
              },
              leadingWidget: Row(
                children: [
                  10.horizontalSpace,
                  ImageWidget(
                    imageUrl: Assets.images.svgs.bulb,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              leadingIconUrl: Assets.images.svgs.bulb,
              tittle: 'Preferences'),
          24.verticalSpace,
          SettingListTile(
              leadingIconUrl: Assets.images.svgs.star, tittle: 'Give feedback'),
          24.verticalSpace,
          SettingListTile(
              leadingIconUrl: Assets.images.svgs.supportIcon,
              tittle: 'Support'),
        ],
      ),
    ));
  }
}
