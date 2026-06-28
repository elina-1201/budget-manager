import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_base_url.g.dart';

const _devMachineIp = '192.168.0.7';
const _devPort = 8080;

const _isPhysicalDevice = bool.fromEnvironment('PHYSICAL_DEVICE');

// HACK Run with `--dart-define=PHYSICAL_DEVICE=true` on a real device.

@riverpod
String apiBaseUrl(Ref ref) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return _isPhysicalDevice
        ? 'http://$_devMachineIp:$_devPort'
        : 'http://10.0.2.2:$_devPort';
  }
  return 'http://localhost:$_devPort';
}
