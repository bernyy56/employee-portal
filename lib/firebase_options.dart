
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyC9vtd7rMrMmRsg0OrPkbcMoVWvKyWQ6bo',
    appId: '1:991545262849:web:057e435f1455e334715100',
    messagingSenderId: '991545262849',
    projectId: 'flutterapp-b621d',
    authDomain: 'flutterapp-b621d.firebaseapp.com',
    storageBucket: 'flutterapp-b621d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdt1vNigS-Z4PBkjV0E4sWYlQZCNxPV6c',
    appId: '1:991545262849:android:a6639cec7c237f10715100',
    messagingSenderId: '991545262849',
    projectId: 'flutterapp-b621d',
    storageBucket: 'flutterapp-b621d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2-c16h-l0_HS0KbtwDNknnYs070D3J88',
    appId: '1:991545262849:ios:9510c8a09fc74836715100',
    messagingSenderId: '991545262849',
    projectId: 'flutterapp-b621d',
    storageBucket: 'flutterapp-b621d.appspot.com',
    iosBundleId: 'com.example.appMcd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2-c16h-l0_HS0KbtwDNknnYs070D3J88',
    appId: '1:991545262849:ios:15afd60227ee6ab2715100',
    messagingSenderId: '991545262849',
    projectId: 'flutterapp-b621d',
    storageBucket: 'flutterapp-b621d.appspot.com',
    iosBundleId: 'com.example.appMcd.RunnerTests',
  );
}
