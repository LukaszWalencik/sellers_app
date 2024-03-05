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
    apiKey: 'AIzaSyAfzPZ-_a-9e71qYKWgas1VqjTpHHBh8h8',
    appId: '1:243049043539:web:4f5c1a8ead4c709587d8a6',
    messagingSenderId: '243049043539',
    projectId: 'foodapp-2b16b',
    authDomain: 'foodapp-2b16b.firebaseapp.com',
    storageBucket: 'foodapp-2b16b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuzhb_I75JVWmRfSE1tpsSbtkU8e8ntv0',
    appId: '1:243049043539:android:8f658eeed5d1d9bb87d8a6',
    messagingSenderId: '243049043539',
    projectId: 'foodapp-2b16b',
    storageBucket: 'foodapp-2b16b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrEWT8_hrZf7WWHiPx3UOlPq3XYgcNAlM',
    appId: '1:243049043539:ios:13e7369445db92b387d8a6',
    messagingSenderId: '243049043539',
    projectId: 'foodapp-2b16b',
    storageBucket: 'foodapp-2b16b.appspot.com',
    iosBundleId: 'com.example.sellersApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrEWT8_hrZf7WWHiPx3UOlPq3XYgcNAlM',
    appId: '1:243049043539:ios:ac3272f3fcb9eabf87d8a6',
    messagingSenderId: '243049043539',
    projectId: 'foodapp-2b16b',
    storageBucket: 'foodapp-2b16b.appspot.com',
    iosBundleId: 'com.example.sellersApp.RunnerTests',
  );
}