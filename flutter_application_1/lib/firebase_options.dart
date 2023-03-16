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
    apiKey: 'AIzaSyBHE5AxAGx-pH1KARjLuDVETjeDidqAcg4',
    appId: '1:824056116535:web:6961ce22426896ebd096b2',
    messagingSenderId: '824056116535',
    projectId: 'fir-b2082',
    authDomain: 'fir-b2082.firebaseapp.com',
    storageBucket: 'fir-b2082.appspot.com',
    measurementId: 'G-W2YY7VR6J6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDi8BjBwt43vP8-UqCjqvfHKtVgmEsuYzo',
    appId: '1:824056116535:android:0508738a627eeea0d096b2',
    messagingSenderId: '824056116535',
    projectId: 'fir-b2082',
    storageBucket: 'fir-b2082.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDT0JF2O8Hc499miuPwIfNiQYdlnvRNWd4',
    appId: '1:824056116535:ios:d0bd52eca4097e0cd096b2',
    messagingSenderId: '824056116535',
    projectId: 'fir-b2082',
    storageBucket: 'fir-b2082.appspot.com',
    iosClientId: '824056116535-5dcj3ntmgekg7i9qo78n1fdd7mfqs9u1.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDT0JF2O8Hc499miuPwIfNiQYdlnvRNWd4',
    appId: '1:824056116535:ios:d0bd52eca4097e0cd096b2',
    messagingSenderId: '824056116535',
    projectId: 'fir-b2082',
    storageBucket: 'fir-b2082.appspot.com',
    iosClientId: '824056116535-5dcj3ntmgekg7i9qo78n1fdd7mfqs9u1.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}