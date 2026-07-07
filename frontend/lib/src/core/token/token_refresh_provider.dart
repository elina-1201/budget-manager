import 'package:budget_manager/src/core/config/api_base_url.dart';
import 'package:budget_manager/src/core/storage/auth_storage_provider.dart';
import 'package:budget_manager/src/core/token/token_refresh_service.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_refresh_provider.g.dart';

@Riverpod(keepAlive: true)
TokenRefreshService tokenRefresh(Ref ref) {
  return TokenRefreshService(
    authStorage: ref.read(authStorageProvider),
    dioFactory: () => Dio(BaseOptions(baseUrl: ref.read(apiBaseUrlProvider))),
  );
}
