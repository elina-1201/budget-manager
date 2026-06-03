import 'package:flutter/foundation.dart';

class ApiBaseUrl {
  static String get() {
    //TODO: make web compatible

    // Android emulator -> host machine
    // iOS simulator -> localhost works
    // real device -> use your LAN IP
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080';
    }
    return 'http://localhost:8080';
  }
}
