import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_base_url.g.dart';

// @riverpod
// String apiBaseUrl(Ref ref) {
//   // Android emulator -> host machine
//   // iOS simulator -> localhost works
//   // real device -> use your LAN IP
//   // web -> use localhost or your backend URL
//   if (defaultTargetPlatform == TargetPlatform.android) {
//     return 'http://10.0.2.2:8080';
//   }
//   // else if (defaultTargetPlatform == TargetPlatform.iOS) {
//   //   return 'http://localhost:8080';
//   // } else if (kIsWeb) {
//   //   return 'http://localhost:8080'; // or your backend URL
//   // }
//   return 'http://localhost:8080';
// }

//HACK: run if debugging on physical device: `flutter run --dart-define=USE_LAN=true`
const _devMachineIp = '192.168.0.7';
const _devPort = 8080;

const _useLan = bool.fromEnvironment('USE_LAN');

@riverpod
String apiBaseUrl(Ref ref) =>
    _useLan ? 'http://$_devMachineIp:$_devPort' : 'http://10.0.2.2:$_devPort';
