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
    apiKey: 'AIzaSyBe9nnmZVGCIeNwx9QaMzEkR3zgcITpSjU',
    appId: '1:139290844398:web:8f9b4394214a46e5d627ff',
    messagingSenderId: '139290844398',
    projectId: 'mypaws-b29a1',
    authDomain: 'mypaws-b29a1.firebaseapp.com',
    storageBucket: 'mypaws-b29a1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFRGlV57hLoGWobTuJPf8q0ocwEx1hJ4k',
    appId: '1:139290844398:android:b0a09c4598d3b27fd627ff',
    messagingSenderId: '139290844398',
    projectId: 'mypaws-b29a1',
    storageBucket: 'mypaws-b29a1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8Yd0uDp-YWVkISKTfZAw2YVczRsBQpx0',
    appId: '1:139290844398:ios:ba7283c461a77066d627ff',
    messagingSenderId: '139290844398',
    projectId: 'mypaws-b29a1',
    storageBucket: 'mypaws-b29a1.appspot.com',
    iosClientId: '139290844398-k6ecakdg0cfniji3d1guomrn8nn46nqd.apps.googleusercontent.com',
    iosBundleId: 'com.example.mypaws',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8Yd0uDp-YWVkISKTfZAw2YVczRsBQpx0',
    appId: '1:139290844398:ios:ba7283c461a77066d627ff',
    messagingSenderId: '139290844398',
    projectId: 'mypaws-b29a1',
    storageBucket: 'mypaws-b29a1.appspot.com',
    iosClientId: '139290844398-k6ecakdg0cfniji3d1guomrn8nn46nqd.apps.googleusercontent.com',
    iosBundleId: 'com.example.mypaws',
  );
}
