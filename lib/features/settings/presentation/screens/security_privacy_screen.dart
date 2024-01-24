import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';

class SecurityPrivacyScreen extends StatefulWidget {
  const SecurityPrivacyScreen({super.key});

  @override
  State<SecurityPrivacyScreen> createState() => _SecurityPrivacyScreenState();
}

class _SecurityPrivacyScreenState extends State<SecurityPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Security & Privacy',
      ),
      body: Stack(
        children: [
          const AppBg(),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                100.verticalSpace,
                Container(
                    decoration: BoxDecoration(
                        color: Pallets.white,
                        borderRadius: BorderRadius.circular(17)),
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Column(
                        children: [
                          SettingListTile(
                              onTap: () {
                                context.pushNamed(PageUrl.changePasscodeScreen);
                              },
                              leadingWidget: 0.horizontalSpace,
                              tittle: 'Change PIN'),
                          35.verticalSpace,
                          SettingListTile(
                              onTap: () {},
                              leadingWidget: 0.horizontalSpace,
                              trailingWidget: CupertinoSwitch(
                                value: true,
                                onChanged: (value) {},
                              ),
                              tittle: 'Sign in with Face ID'),
                        ],
                      ),
                    )),
                10.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                      color: Pallets.white,
                      borderRadius: BorderRadius.circular(17)),
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: SettingListTile(
                        onTap: () {},
                        leadingWidget: 0.horizontalSpace,
                        tittle: 'Change Language'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
