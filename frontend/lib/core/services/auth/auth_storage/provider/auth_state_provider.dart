import 'package:budget_manager/core/services/auth/auth_storage/provider/auth_storage_provider.dart';
import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Future<bool> build() async {
    return await _isTokenValidOrRefresh();
  }

  Future<bool> _isTokenValidOrRefresh() async {
    final storage = ref.read(authStorageProvider);
    final token = await storage.getAccessToken();

    if (token == null) return false;
    if (!JwtDecoder.isExpired(token)) return true;

    final refreshToken = await storage.getRefreshToken();
    if (refreshToken == null) {
      await storage.deleteTokens();
      return false;
    }

    try {
      final refreshDio = ref.read(dioProvider);
      final response = await refreshDio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      await storage.saveTokens(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
      );

      return true;
    } on DioException {
      await storage.deleteTokens();
      return false;
    }
  }

  Future<void> storeTokensOnAuth(
    String accessToken,
    String refreshToken,
  ) async {
    await ref
        .read(authStorageProvider)
        .saveTokens(accessToken: accessToken, refreshToken: refreshToken);
    ref.invalidateSelf();
    state = const AsyncData(true);
  }

  Future<void> logout() async {
    await ref.read(authStorageProvider).deleteTokens();
    ref.invalidateSelf();
    state = const AsyncData(false);
  }
}
