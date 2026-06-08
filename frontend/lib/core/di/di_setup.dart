import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../services/auth_storage.dart';
import '../config/base_url.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<String>(ApiBaseUrl.get());
  getIt.registerLazySingleton(() => Dio());
  setupLocator();
}

void setupLocator() {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => AuthStorage(getIt<FlutterSecureStorage>()));
  // getIt.registerLazySingleton(() => AuthInterceptor(getIt<AuthStorage>()));
}
