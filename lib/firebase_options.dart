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
    apiKey: 'AIzaSyB-AAJCAwd0JooSSe2ybvpKyr8bot0bKMY',
    appId: '1:1062060447304:web:cd5f4b712586112b296a7d',
    messagingSenderId: '1062060447304',
    projectId: 'e-commerce-app-e1f57',
    authDomain: 'e-commerce-app-e1f57.firebaseapp.com',
    storageBucket: 'e-commerce-app-e1f57.firebasestorage.app',
    measurementId: 'G-J1ESVWG98S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDx2dax7F6qUc4OLuDbORHmvpgSi0iJEfo',
    appId: '1:1062060447304:android:353546d2c9ef82cd296a7d',
    messagingSenderId: '1062060447304',
    projectId: 'e-commerce-app-e1f57',
    storageBucket: 'e-commerce-app-e1f57.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCQPHxs5vIbtCWlyDzXxTSs2Et18C2IPc',
    appId: '1:1062060447304:ios:97976ad5670c7fdd296a7d',
    messagingSenderId: '1062060447304',
    projectId: 'e-commerce-app-e1f57',
    storageBucket: 'e-commerce-app-e1f57.firebasestorage.app',
    iosBundleId: 'com.example.eCommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDCQPHxs5vIbtCWlyDzXxTSs2Et18C2IPc',
    appId: '1:1062060447304:ios:97976ad5670c7fdd296a7d',
    messagingSenderId: '1062060447304',
    projectId: 'e-commerce-app-e1f57',
    storageBucket: 'e-commerce-app-e1f57.firebasestorage.app',
    iosBundleId: 'com.example.eCommerce',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB-AAJCAwd0JooSSe2ybvpKyr8bot0bKMY',
    appId: '1:1062060447304:web:884359ef284b4268296a7d',
    messagingSenderId: '1062060447304',
    projectId: 'e-commerce-app-e1f57',
    authDomain: 'e-commerce-app-e1f57.firebaseapp.com',
    storageBucket: 'e-commerce-app-e1f57.firebasestorage.app',
    measurementId: 'G-3KPPH7PVPK',
  );
}
