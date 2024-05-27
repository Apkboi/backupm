import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';
import 'package:mentra/gen/assets.gen.dart';

class SettingsGroup1 extends StatelessWidget {
  const SettingsGroup1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: _listenToSettingsBloc,
      bloc: injector.get<SettingsBloc>(),
      builder: (context, state) {
        var bloc = injector.get<SettingsBloc>();
        return GlassContainer(
            child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              SettingListTile(
                leadingIconUrl: Assets.images.svgs.bellFilled,
                tittle: 'Notifications',
                trailingWidget: CupertinoSwitch(
                  value: injector.get<SettingsBloc>().notificationsEnabled,
                  onChanged: (value) {
                    if (!bloc.notificationsEnabled) {
                      bloc.add(const SwitchNotificationEnabledEvent(true));
                    } else {
                      bloc.add(const SwitchNotificationEnabledEvent(false));
                    }
                  },
                ),
              ),
              24.verticalSpace,
              SettingListTile(
                leadingIconUrl: Assets.images.svgs.bellFilled,
                tittle: 'Enable sounds',
                trailingWidget: CupertinoSwitch(
                  value: bloc.soundEnabled,
                  onChanged: (value) {
                    logger.w(bloc.soundEnabled);
                    if (!bloc.soundEnabled) {
                      bloc.add(const SwitchSoundEnabledEvent(true));
                    } else {
                      bloc.add(const SwitchSoundEnabledEvent(false));
                    }
                  },
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
                    context.pushNamed(PageUrl.userPreferenceScreen,
                        queryParameters: {
                          PathParam.userPreferenceFlow:
                              UserPreferenceFlow.updatePreference.name,
                          PathParam.chatIntent:
                              TherapyPreferenceIntent.updatePreference.name,
                        });
                  },
                  leadingWidget: Row(
                    children: [
                      10.horizontalSpace,
                      ImageWidget(
                        size: 17.w,
                        imageUrl: Assets.images.svgs.bulb,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  leadingIconUrl: Assets.images.svgs.bulb,
                  tittle: 'Therapist Preferences'),
              // 24.verticalSpace,
              // SettingListTile(
              //     onTap: () {
              //       Helpers.launchEmailWithMessage(email: 'support@mentra.com');
              //     },
              //     leadingIconUrl: Assets.images.svgs.star,
              //     tittle: 'Give feedback'),
              24.verticalSpace,
              SettingListTile(
                  onTap: () {
                    context.pushNamed(PageUrl.supportScreen);
                  },
                  leadingIconUrl: Assets.images.svgs.supportIcon,
                  tittle: 'Support'),
            ],
          ),
        ));
      },
    );
  }

  void _listenToSettingsBloc(BuildContext context, SettingsState state) {}
}
