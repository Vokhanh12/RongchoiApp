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
        return windows;
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
    apiKey: 'AIzaSyATxl_o0bJu9YB02qbmY9bW3aNHL2mqvvk',
    appId: '1:925989931895:web:60ff81f4b74e2c18022f72',
    messagingSenderId: '925989931895',
    projectId: 'rongchoi-e9690',
    authDomain: 'rongchoi-e9690.firebaseapp.com',
    storageBucket: 'rongchoi-e9690.appspot.com',
    measurementId: 'G-FDFKZN1B8J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEU_2QacBzTsI_Fx0Eo1PU5LcfN-WhbPc',
    appId: '1:925989931895:android:c7e88650683e3583022f72',
    messagingSenderId: '925989931895',
    projectId: 'rongchoi-e9690',
    storageBucket: 'rongchoi-e9690.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBLNkQyqKMp8yvzP6NaalOnE8r7WCIdx4',
    appId: '1:925989931895:ios:0096649e5e1c4355022f72',
    messagingSenderId: '925989931895',
    projectId: 'rongchoi-e9690',
    storageBucket: 'rongchoi-e9690.appspot.com',
    iosBundleId: 'com.example.rongchoiApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBLNkQyqKMp8yvzP6NaalOnE8r7WCIdx4',
    appId: '1:925989931895:ios:0096649e5e1c4355022f72',
    messagingSenderId: '925989931895',
    projectId: 'rongchoi-e9690',
    storageBucket: 'rongchoi-e9690.appspot.com',
    iosBundleId: 'com.example.rongchoiApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyATxl_o0bJu9YB02qbmY9bW3aNHL2mqvvk',
    appId: '1:925989931895:web:cd8c0ae479698e4f022f72',
    messagingSenderId: '925989931895',
    projectId: 'rongchoi-e9690',
    authDomain: 'rongchoi-e9690.firebaseapp.com',
    storageBucket: 'rongchoi-e9690.appspot.com',
    measurementId: 'G-XX8YKR716T',
  );

}