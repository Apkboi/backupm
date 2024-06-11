import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentra/features/therapy/presentation/screens/call_listener.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:mentra/app_config.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/core/services/theme_service/app_theme.dart';
import 'core/constants/package_exports.dart';
import 'core/navigation/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/dashboard/presentation/screens/deep_link_listener.dart';
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

class _MentraAppState extends State<MentraApp> {
  @override
  void initState() {
    // _initMesibo();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarColor: Pallets.primary,
    //     systemStatusBarContrastEnforced: true,
    //     // statusBarIconBrightness: Brightness.dark,
    //     systemNavigationBarColor: Pallets.primary,
    //     systemNavigationBarDividerColor: Pallets.primary,
    //     // systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    // );
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      // designSize: ScreenUtil.defaultSize,
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, child) {
        return OverlaySupport.global(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: DeepLinkListener(
              child: CallListener(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
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
            ),
          ),
        );
      },
    );
  }

// void _initMesibo() async {
//   mesibo.setAccessToken('abcd6582a9d25c85cbf4c9386e5d3529cdbb8f89d911dab801fae224ad1e4ga1499143eaf');
//   mesibo.setListener(MesiboCubit());
//   mesibo.start();
//
//   logger.i(await mesibo.getAddress());
//   logger.i(await mesibo.getUid());
// }
}
