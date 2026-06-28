import 'package:budget_manager/core/config/base_url/api_base_url.dart';
import 'package:budget_manager/core/services/auth/storage/provider/auth_storage_provider.dart';
import 'package:budget_manager/core/services/token_refresh/token_refresh.dart';
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
