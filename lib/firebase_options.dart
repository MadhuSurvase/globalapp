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
    apiKey: 'AIzaSyB7USSXpCzxSSI7zAaaDP58ZcNzYfudKx8',
    appId: '1:261969516336:web:d41e8e6156089937369af5',
    messagingSenderId: '261969516336',
    projectId: 'customerapp-e5853',
    authDomain: 'customerapp-e5853.firebaseapp.com',
    storageBucket: 'customerapp-e5853.appspot.com',
    measurementId: 'G-57H7EPX28D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJgN80yJ_MR3WO-TnhlKjR-sqU3wXrsEY',
    appId: '1:261969516336:android:1c4fe2ea9c2056e5369af5',
    messagingSenderId: '261969516336',
    projectId: 'customerapp-e5853',
    storageBucket: 'customerapp-e5853.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwLN-xTMMN-DnqMsjanppuzR0TFxg_Thw',
    appId: '1:261969516336:ios:fe166c777f085a8f369af5',
    messagingSenderId: '261969516336',
    projectId: 'customerapp-e5853',
    storageBucket: 'customerapp-e5853.appspot.com',
    iosBundleId: 'com.example.globalapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwLN-xTMMN-DnqMsjanppuzR0TFxg_Thw',
    appId: '1:261969516336:ios:fe166c777f085a8f369af5',
    messagingSenderId: '261969516336',
    projectId: 'customerapp-e5853',
    storageBucket: 'customerapp-e5853.appspot.com',
    iosBundleId: 'com.example.globalapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7USSXpCzxSSI7zAaaDP58ZcNzYfudKx8',
    appId: '1:261969516336:web:ce306c2ac337749d369af5',
    messagingSenderId: '261969516336',
    projectId: 'customerapp-e5853',
    authDomain: 'customerapp-e5853.firebaseapp.com',
    storageBucket: 'customerapp-e5853.appspot.com',
    measurementId: 'G-X4W3C508VV',
  );
}
