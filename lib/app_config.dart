import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentra/app.dart';
import 'package:mentra/core/services/stripe/stripe_service.dart';
import 'core/di/injector.dart';
import 'core/services/data/hive/hive_manager.dart';
import 'core/services/data/session_manager.dart';
import 'core/services/firebase/crashlytics.dart';
import 'core/services/firebase/notifiactions.dart';
import 'core/services/mesibo/mesibo_service.dart';
import 'core/services/network/url_config.dart';
import 'package:mentra/core/di/injector.dart' as di;
import 'features/account/presentation/user_bloc/user_bloc.dart';
import 'firebase_options.dart';

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
    await DefaultCacheManager().emptyCache();

    await Hive.initFlutter();
    // var remoteConfigsService = RemoteConfigsService.create();
    // remoteConfigsService.retrieveSecrets();
    await di.init();
    await initializeDB();
    await initCore();
    await setup();
    runApp(const MentraApp());
    // FlutterNativeSplash.remove();
  }

  Future setup() async {
    injector.get<UserBloc>().add(GetUserEvent());

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
Future<void> _ensureScreenSize(SingletonFlutterWindow window) async {
  return window.physicalGeometry.isEmpty
      ? Future.delayed(
          const Duration(milliseconds: 10), () => _ensureScreenSize(window))
      : Future.value();
}
