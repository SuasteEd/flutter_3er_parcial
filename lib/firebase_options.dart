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
    apiKey: 'AIzaSyAPgY6SFaqEks1Jta9DIaaC5Jeu9vBv1sU',
    appId: '1:1075556862215:web:32a92dc880649e8fc79da2',
    messagingSenderId: '1075556862215',
    projectId: 'todolistproject-28f42',
    authDomain: 'todolistproject-28f42.firebaseapp.com',
    storageBucket: 'todolistproject-28f42.appspot.com',
    measurementId: 'G-HRRPBQQ8P4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFSoBrNdxayMiEUJ7viAXZ-d7YexfRB5s',
    appId: '1:1075556862215:android:70d1cdfd87b2dfaec79da2',
    messagingSenderId: '1075556862215',
    projectId: 'todolistproject-28f42',
    storageBucket: 'todolistproject-28f42.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaxq4aqUmxwIPUlPYo8h4A9Zi4g-tzSsA',
    appId: '1:1075556862215:ios:7ab9e8bea6fd7317c79da2',
    messagingSenderId: '1075556862215',
    projectId: 'todolistproject-28f42',
    storageBucket: 'todolistproject-28f42.appspot.com',
    iosBundleId: 'com.example.examen3erParcial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaxq4aqUmxwIPUlPYo8h4A9Zi4g-tzSsA',
    appId: '1:1075556862215:ios:7ab9e8bea6fd7317c79da2',
    messagingSenderId: '1075556862215',
    projectId: 'todolistproject-28f42',
    storageBucket: 'todolistproject-28f42.appspot.com',
    iosBundleId: 'com.example.examen3erParcial',
  );
}