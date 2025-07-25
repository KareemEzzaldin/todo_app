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
    apiKey: 'AIzaSyBhT8dPSy3IoIAucAohyGfrbgGXiozBl_M',
    appId: '1:247959384196:web:302b8dd98327678dcfd2d1',
    messagingSenderId: '247959384196',
    projectId: 'todo-app-c2bc0',
    authDomain: 'todo-app-c2bc0.firebaseapp.com',
    storageBucket: 'todo-app-c2bc0.firebasestorage.app',
    measurementId: 'G-ZNGYTL6MSW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUwsXwHoVYh5oi3X9eYghp5aBEzb_B6-U',
    appId: '1:247959384196:android:ef8f16c9cc26af1dcfd2d1',
    messagingSenderId: '247959384196',
    projectId: 'todo-app-c2bc0',
    storageBucket: 'todo-app-c2bc0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDi4OOvIWP7VpHfWu5vksXfrtqZQKCD-g4',
    appId: '1:247959384196:ios:66861b0e24b65e7bcfd2d1',
    messagingSenderId: '247959384196',
    projectId: 'todo-app-c2bc0',
    storageBucket: 'todo-app-c2bc0.firebasestorage.app',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDi4OOvIWP7VpHfWu5vksXfrtqZQKCD-g4',
    appId: '1:247959384196:ios:66861b0e24b65e7bcfd2d1',
    messagingSenderId: '247959384196',
    projectId: 'todo-app-c2bc0',
    storageBucket: 'todo-app-c2bc0.firebasestorage.app',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBhT8dPSy3IoIAucAohyGfrbgGXiozBl_M',
    appId: '1:247959384196:web:eb850610c6ce1ef5cfd2d1',
    messagingSenderId: '247959384196',
    projectId: 'todo-app-c2bc0',
    authDomain: 'todo-app-c2bc0.firebaseapp.com',
    storageBucket: 'todo-app-c2bc0.firebasestorage.app',
    measurementId: 'G-LS4JSEQX1V',
  );

}