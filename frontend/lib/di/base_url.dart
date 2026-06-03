import 'package:flutter/foundation.dart';

class ApiBaseUrl {
  static String get() {
    // Android emulator -> host machine
    // iOS simulator -> localhost works
    // real device -> use your LAN IP
    // web -> use localhost or your backend URL
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080';
    }
    // else if (defaultTargetPlatform == TargetPlatform.iOS) {
    //   return 'http://localhost:8080';
    // } else if (kIsWeb) {
    //   return 'http://localhost:8080'; // or your backend URL
    // }
    return 'http://localhost:8080';
  }
}
