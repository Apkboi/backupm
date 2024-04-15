import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/local_auth/presentation/blocs/local_auth/local_auth_cubit.dart';
import 'package:mentra/features/authentication/local_auth/presentation/blocs/local_auth/local_auth_cubit.dart';
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
                              tittle: 'Change PIN'),
                          35.verticalSpace,
                          BlocBuilder<LocalAuthCubit, LocalAuthState>(
                            bloc: injector.get(),
                            builder: (context, state) {
                              return SettingListTile(
                                  onTap: () {
                                    // LocalAuthentication().authenticate(localizedReason: 'c,d');
                                  },
                                  trailingWidget: CupertinoSwitch(
                                    value: injector
                                        .get<LocalAuthCubit>()
                                        .biometricEnabled,
                                    onChanged: (value) {
                                      if (!injector
                                          .get<LocalAuthCubit>()
                                          .biometricEnabled) {
                                        injector
                                            .get<LocalAuthCubit>()
                                            .enableBiometric();
                                      } else {
                                        injector
                                            .get<LocalAuthCubit>()
                                            .disableBiometric();
                                      }
                                    },
                                  ),
                                  tittle: 'Sign in with Biometric');
                            },
                          ),
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
                        // leadingWidget: 0.horizontalSpace,
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
