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
    apiKey: 'AIzaSyBPYokAkGZ618mHrViUTqhlG1UK44UrcmM',
    appId: '1:497327083118:web:00d73c8e7c9f5b41b1a07f',
    messagingSenderId: '497327083118',
    projectId: 'fleetgroupproject',
    authDomain: 'fleetgroupproject.firebaseapp.com',
    storageBucket: 'fleetgroupproject.appspot.com',
    measurementId: 'G-V8VMJQV13Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAE7HTxiqXsjfpetysK3QEEDRB5qSmBPBM',
    appId: '1:497327083118:android:1caef9ba42232042b1a07f',
    messagingSenderId: '497327083118',
    projectId: 'fleetgroupproject',
    storageBucket: 'fleetgroupproject.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRwZBRzC07av4VNhU5Kig5oHuf8JoPzgw',
    appId: '1:497327083118:ios:c96c25295fb23b68b1a07f',
    messagingSenderId: '497327083118',
    projectId: 'fleetgroupproject',
    storageBucket: 'fleetgroupproject.appspot.com',
    iosClientId: '497327083118-337fkacok2g152ioo2dp081bm93m2c15.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginPage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRwZBRzC07av4VNhU5Kig5oHuf8JoPzgw',
    appId: '1:497327083118:ios:c96c25295fb23b68b1a07f',
    messagingSenderId: '497327083118',
    projectId: 'fleetgroupproject',
    storageBucket: 'fleetgroupproject.appspot.com',
    iosClientId: '497327083118-337fkacok2g152ioo2dp081bm93m2c15.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginPage',
  );
}
