import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'auth_storage.dart';
import 'base_url.dart';
import '../pages/items_list/repository/item_repository.dart';

final getIt = GetIt.instance;

void diInitialization() {
  getIt.registerSingleton<String>(ApiBaseUrl.get());
  getIt.registerLazySingleton(() => ItemRepository(dio: Dio()));
  setupLocator();
}

void setupLocator() {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => AuthStorage(getIt<FlutterSecureStorage>()));
  // getIt.registerLazySingleton(() => AuthInterceptor(getIt<AuthStorage>()));
}
