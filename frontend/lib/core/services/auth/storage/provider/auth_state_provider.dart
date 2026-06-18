import 'package:budget_manager/core/services/auth/auth_mode_enum.dart';
import 'package:budget_manager/core/services/auth/storage/provider/auth_storage_provider.dart';
import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/core/services/shared_prefs/provider/shared_prefs_provider.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  static const _guestKey = 'is_guest';

  @override
  Future<AuthMode> build() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);

    if (prefs.getBool(_guestKey) ?? false) return AuthMode.guest;
    final bool isTokenValid = await _isTokenValidOrRefresh();
    return isTokenValid ? AuthMode.authenticated : AuthMode.unauthenticated;
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
      final baseUrl = ref.read(dioProvider).options.baseUrl;
      final refreshDio = Dio(BaseOptions(baseUrl: baseUrl));
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
    state = const AsyncData(AuthMode.authenticated);
  }

  Future<void> enterGuestMode() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool(_guestKey, true);
    state = const AsyncData(AuthMode.guest);
  }

  Future<void> upgradeFromGuestMode(
    String accessToken,
    String refreshToken,
  ) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.remove(_guestKey);
    await storeTokensOnAuth(accessToken, refreshToken);
    state = const AsyncData(AuthMode.authenticated);
  }

  Future<void> logout() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.remove(_guestKey);
    await ref.read(authStorageProvider).deleteTokens();
    ref.invalidateSelf();
    state = const AsyncData(AuthMode.unauthenticated);
  }
}
