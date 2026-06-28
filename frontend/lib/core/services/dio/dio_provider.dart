import 'package:budget_manager/core/config/base_url/api_base_url.dart';
import 'package:budget_manager/core/services/auth/storage/provider/auth_storage_provider.dart';
import 'package:budget_manager/core/services/token_refresh/provider/token_refresh_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/auth_interceptor.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final baseUrl = ref.read(apiBaseUrlProvider);
  final authStorage = ref.read(authStorageProvider);
  final tokenRefreshService = ref.read(tokenRefreshProvider);
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.add(AuthInterceptor(authStorage, tokenRefreshService, dio));
  return dio;
}
