import 'package:budget_manager/core/config/api_base_url.dart';
import 'package:budget_manager/core/exceptions/error_mapper_provider.dart';
import 'package:budget_manager/core/http/auth_interceptor.dart';
import 'package:budget_manager/core/http/error_interceptor.dart';
import 'package:budget_manager/core/storage/auth_storage_provider.dart';
import 'package:budget_manager/core/token/token_refresh_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final baseUrl = ref.read(apiBaseUrlProvider);
  final authStorage = ref.read(authStorageProvider);
  final tokenRefreshService = ref.read(tokenRefreshProvider);
  final errorMapper = ref.read(errorMapperProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  dio.interceptors.addAll([
    AuthInterceptor(authStorage, tokenRefreshService, dio),
    ErrorMappingInterceptor(errorMapper),
  ]);
  return dio;
}
