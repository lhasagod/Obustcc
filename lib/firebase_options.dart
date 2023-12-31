// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart'
    show FirebaseOptions;
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
    apiKey: 'AIzaSyB0G_6M6d0Rks8BAUzjiKuRkUjMj5Xo7T4',
    appId: '1:272309223734:web:2b927494a6ef22587cb397',
    messagingSenderId: '272309223734',
    projectId: 'tccbus-efdc1',
    authDomain: 'tccbus-efdc1.firebaseapp.com',
    databaseURL: 'https://tccbus-efdc1-default-rtdb.firebaseio.com',
    storageBucket: 'tccbus-efdc1.appspot.com',
    measurementId: 'G-13T5WVX0YV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFcPM55J68CgSCV_47-ROpwiTLgjxv-Zk',
    appId: '1:272309223734:android:00060ed82b389cce7cb397',
    messagingSenderId: '272309223734',
    projectId: 'tccbus-efdc1',
    databaseURL: 'https://tccbus-efdc1-default-rtdb.firebaseio.com',
    storageBucket: 'tccbus-efdc1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVlWWfWDuBVWkfhzf9vfhDht9KzpNZkSQ',
    appId: '1:272309223734:ios:2243b99544895dee7cb397',
    messagingSenderId: '272309223734',
    projectId: 'tccbus-efdc1',
    databaseURL: 'https://tccbus-efdc1-default-rtdb.firebaseio.com',
    storageBucket: 'tccbus-efdc1.appspot.com',
    iosClientId: '272309223734-97ocsnkrkfqvq4gce599l7tphn734n9a.apps.googleusercontent.com',
    iosBundleId: 'com.example.obus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVlWWfWDuBVWkfhzf9vfhDht9KzpNZkSQ',
    appId: '1:272309223734:ios:2243b99544895dee7cb397',
    messagingSenderId: '272309223734',
    projectId: 'tccbus-efdc1',
    databaseURL: 'https://tccbus-efdc1-default-rtdb.firebaseio.com',
    storageBucket: 'tccbus-efdc1.appspot.com',
    iosClientId: '272309223734-97ocsnkrkfqvq4gce599l7tphn734n9a.apps.googleusercontent.com',
    iosBundleId: 'com.example.obus',
  );
}
