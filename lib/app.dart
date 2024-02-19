import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:mentra/app_config.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/core/services/theme_service/app_theme.dart';
import 'core/constants/package_exports.dart';
import 'core/navigation/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  AppConfig.initializeAndRunInstance(
      appName: "Mentra", enviroment: Environment.staging);
}

class MentraApp extends StatelessWidget {
  const MentraApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      // designSize: ScreenUtil.defaultSize,
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (contextAlt, child) {
        return OverlaySupport.global(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp.router(
              title: "Mentra",
              //TODO: SET LOCALE HERE
              // locale: ref.watch(localeProvider).locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,

              // theme: ThemeData(
              //   primarySwatch: Colors.blueGrey,
              // ),
              //
              theme: AppTheme.lightTheme,
              // darkTheme: AppTheme.darkTheme,
              routerConfig: CustomRoutes.goRouter,
            ),
          ),
        );
      },
    );
  }
}
