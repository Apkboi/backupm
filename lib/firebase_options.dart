// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAH_2Kla7rGNrdTFhefYbYSxbpk0UPjO1w',
    appId: '1:469691765994:web:8b34df2b0d01005244b393',
    messagingSenderId: '469691765994',
    projectId: 'mentra-2323f',
    authDomain: 'mentra-2323f.firebaseapp.com',
    storageBucket: 'mentra-2323f.appspot.com',
    measurementId: 'G-C055LQ1M7G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2tnX54R2stFkTn6ogP95h4GW5BTET6Jk',
    appId: '1:469691765994:android:9ab1f3088154314144b393',
    messagingSenderId: '469691765994',
    projectId: 'mentra-2323f',
    storageBucket: 'mentra-2323f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeJOQj5lGOFetYVHBULTIvVS2-HQJpa8A',
    appId: '1:469691765994:ios:e528b90603bc393944b393',
    messagingSenderId: '469691765994',
    projectId: 'mentra-2323f',
    storageBucket: 'mentra-2323f.appspot.com',
    androidClientId:
        '469691765994-p131ofo9501662c3v016lapuh1r2g4h4.apps.googleusercontent.com',
    iosClientId:
        '469691765994-mpvuctgp9epjihb9gs0bj138alged9jg.apps.googleusercontent.com',
    iosBundleId: 'com.mentraapp.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeJOQj5lGOFetYVHBULTIvVS2-HQJpa8A',
    appId: '1:469691765994:ios:62fa24625d238b3044b393',
    messagingSenderId: '469691765994',
    projectId: 'mentra-2323f',
    storageBucket: 'mentra-2323f.appspot.com',
    androidClientId:
        '469691765994-p131ofo9501662c3v016lapuh1r2g4h4.apps.googleusercontent.com',
    iosClientId:
        '469691765994-ahpdo7k71o5d95ilcmk2bg01nsvfskol.apps.googleusercontent.com',
    iosBundleId: 'com.mentra.app.mentra.RunnerTests',
  );
}
