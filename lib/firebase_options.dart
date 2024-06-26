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
    apiKey: 'AIzaSyAp-hc23rwBtdGNlxfyvb31kOAGJniNMf0',
    appId: '1:79046134887:web:9bc9b51dc08f0b2cf298c2',
    messagingSenderId: '79046134887',
    projectId: 'flutterfire-ui-codelab-c5dee',
    authDomain: 'flutterfire-ui-codelab-c5dee.firebaseapp.com',
    storageBucket: 'flutterfire-ui-codelab-c5dee.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcwR4UIKW93nR5TsQVqo0jjB88l0P54iU',
    appId: '1:79046134887:android:cf8fe708c401d8dcf298c2',
    messagingSenderId: '79046134887',
    projectId: 'flutterfire-ui-codelab-c5dee',
    storageBucket: 'flutterfire-ui-codelab-c5dee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRxj7VcIHLsibGjIE3I3bOszGWMoU9JO0',
    appId: '1:79046134887:ios:8f337e70e3047766f298c2',
    messagingSenderId: '79046134887',
    projectId: 'flutterfire-ui-codelab-c5dee',
    storageBucket: 'flutterfire-ui-codelab-c5dee.appspot.com',
    iosBundleId: 'com.example.complete',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRxj7VcIHLsibGjIE3I3bOszGWMoU9JO0',
    appId: '1:79046134887:ios:f0c338ecb0c63115f298c2',
    messagingSenderId: '79046134887',
    projectId: 'flutterfire-ui-codelab-c5dee',
    storageBucket: 'flutterfire-ui-codelab-c5dee.appspot.com',
    iosBundleId: 'com.example.complete.RunnerTests',
  );
}
