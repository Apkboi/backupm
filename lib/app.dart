import 'package:flutter/material.dart';
import 'package:mentra/core/di/injector.dart';

import 'package:mesibo_flutter_sdk/mesibo.dart';
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

class MentraApp extends StatefulWidget {
  const MentraApp({super.key});

  @override
  State<MentraApp> createState() => _MentraAppState();
}

class _MentraAppState extends State<MentraApp>
    implements MesiboConnectionListener {
  @override
  void Mesibo_onConnectionStatus(int status) {
    logger.i(status);
  }

  Mesibo mesibo = Mesibo();

  @override
  void initState() {
    _initMesibo();
    super.initState();
  }

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

  void _initMesibo() async {
    mesibo.setAccessToken(
        'd6582a9d25c85cbf4c9386e5d3529cdbb8f89d911dab801fae224ad1e4ga1499143eaf');
    mesibo.setListener(this);
    mesibo.start();
  }
}
