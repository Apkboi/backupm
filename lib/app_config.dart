import 'dart:isolate';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentra/app.dart';
import 'package:mentra/core/constants/pay_configurations.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/stripe/stripe_service.dart';
import 'package:mentra/features/authentication/local_auth/presentation/blocs/local_auth/local_auth_cubit.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'core/di/injector.dart';
import 'core/services/data/hive/hive_manager.dart';
import 'core/services/data/session_manager.dart';
import 'core/services/firebase/crashlytics.dart';
import 'core/services/firebase/notifiactions.dart';
import 'core/services/network/url_config.dart';
import 'package:mentra/core/di/injector.dart' as di;
import 'core/services/pay/pay_service.dart';
import 'core/services/pusher/pusher_channel_service.dart';
import 'core/services/sentory/sentory_service.dart';
import 'core/services/vibration/haptic_feedback_manager.dart';
import 'features/account/presentation/user_bloc/user_bloc.dart';
import 'firebase_options.dart';

Isolate? vibrationIsolate;

enum Flavor { dev, staging, prod }

class AppConfig {
  final String appName;
  final Environment enviroment;
  Widget? nextScreen;

  AppConfig._({required this.appName, required this.enviroment});

  AppConfig.initializeAndRunInstance(
      {required this.appName, required this.enviroment}) {
    AppConfig._(appName: appName, enviroment: enviroment);
    _init();
  }

  Future<void> _init() async {
    _setup();
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // await Firebase.initializeApp();
    // https: //b71cdbae8346f8596a315ccc07441a73@o915393.ingest.us.sentry.io/4507113240657920

    await CallKitService.instance.initialize();
    PayHelper.instance.initialize(
        defaultGooglePayConfiguration: defaultGooglePay,
        defaultApplePayConfiguration: defaultApplePay);
    StripeService.initialize();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await DefaultCacheManager().emptyCache();
    await Hive.initFlutter();
    // var remoteConfigsService = RemoteConfigsService.create();
    // remoteConfigsService.retrieveSecrets();
    await di.init();
    await initializeDB();
    await initCore();
    await setup();

    SentryService.initializeApp(
        'https://b71cdbae8346f8596a315ccc07441a73@o915393.ingest.us.sentry.io/4507113240657920',
        () => runApp(const MentraApp()));


    // runApp(const MentraApp());
    // FlutterNativeSplash.remove();


  }

  Future setup() async {
    injector.get<UserBloc>().add(GetUserEvent());
    injector.get<LocalAuthCubit>().init();
    injector.get<SettingsBloc>().init();

    // injector.get<DashboardBloc>().add(GetConversationStarterEvent());
  }

  Future<void> initCore() async {
    final window = WidgetsFlutterBinding.ensureInitialized().window;
    await _ensureScreenSize(window);
    final sessionManager = SessionManager();
    // final objectBox = await BoxManager.create();
    await sessionManager.init();
    injector.registerLazySingleton<SessionManager>(() => sessionManager);
    initFirebaseServices();
    var pusherService = await PusherChannelService.getInstance;
    await pusherService.initialize();
  }

  Future<void> initFirebaseServices() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    CrashlyticsService.onCrash();
    await notificationService.initializeNotification();
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    await FirebaseMessaging.instance.getInitialMessage();
    // StripeService.initialize();
    // signMessageUser();
  }

  // void signMessageUser() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: UrlConfig.messageUserEmail,
  //       password: UrlConfig.messageUserPassKey,
  //     );
  //
  //     logger.wtf(credential.user?.email);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       logger.e('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       logger.e('Wrong password provided for that user.');
  //     }
  //   }
  // }

  Future<void> initializeDB() async {
    await Hive.initFlutter();
    // await AudioDaoImpDatasource().init();
    await HiveBoxes.openAllBox();
  }

  Future<void> initializeCountriesList() async {
    // final util = CountryUtil();
  }
}

// Add this function
Future<void> _ensureScreenSize(FlutterView window) async {
  // return window.physicalGeometry.isEmpty
  //     ? Future.delayed(
  //         const Duration(milliseconds: 10), () => _ensureScreenSize(window))
  //     : Future.value();
}
