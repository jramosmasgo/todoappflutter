// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBbS2m5pQtSeAAjSc-LneDFtLdEsaGxulg',
    appId: '1:540125662018:web:da0eff436d084eafa716db',
    messagingSenderId: '540125662018',
    projectId: 'todoapp-ccb80',
    authDomain: 'todoapp-ccb80.firebaseapp.com',
    storageBucket: 'todoapp-ccb80.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRnX0e9s6OaNVtFtAI0bFXcDYOhv7gI5Y',
    appId: '1:540125662018:android:2ee7b3036afdac94a716db',
    messagingSenderId: '540125662018',
    projectId: 'todoapp-ccb80',
    storageBucket: 'todoapp-ccb80.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfr18AmEgR5laUoLmL3Nr_N3y4mLyUEwo',
    appId: '1:540125662018:ios:b78db4533a614be4a716db',
    messagingSenderId: '540125662018',
    projectId: 'todoapp-ccb80',
    storageBucket: 'todoapp-ccb80.appspot.com',
    iosBundleId: 'com.example.todoFriend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfr18AmEgR5laUoLmL3Nr_N3y4mLyUEwo',
    appId: '1:540125662018:ios:b78db4533a614be4a716db',
    messagingSenderId: '540125662018',
    projectId: 'todoapp-ccb80',
    storageBucket: 'todoapp-ccb80.appspot.com',
    iosBundleId: 'com.example.todoFriend',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBbS2m5pQtSeAAjSc-LneDFtLdEsaGxulg',
    appId: '1:540125662018:web:1442bf50c85adf56a716db',
    messagingSenderId: '540125662018',
    projectId: 'todoapp-ccb80',
    authDomain: 'todoapp-ccb80.firebaseapp.com',
    storageBucket: 'todoapp-ccb80.appspot.com',
  );
}