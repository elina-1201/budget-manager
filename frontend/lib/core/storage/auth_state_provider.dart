import 'package:budget_manager/core/storage/auth_state.dart';
import 'package:budget_manager/core/storage/auth_storage_provider.dart';
import 'package:budget_manager/core/storage/shared_prefs_provider.dart';
import 'package:budget_manager/core/token/token_refresh_provider.dart';
import 'package:budget_manager/features/expenses/add/providers/category_notifier.dart';
import 'package:budget_manager/features/expenses/add/providers/selected_category_notifier.dart';
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
    if (isTokenValid) return AuthMode.authenticated;

    // await prefs.setBool(_guestKey, true);
    // return AuthMode.guest;
    return AuthMode.unauthenticated;
  }

  Future<bool> _isTokenValidOrRefresh() async {
    final storage = ref.read(authStorageProvider);
    final token = await storage.getAccessToken();

    if (token == null) return false;
    if (!JwtDecoder.isExpired(token)) return true;

    return ref.read(tokenRefreshProvider).refreshToken();
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
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.remove(_guestKey);
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
    await storeTokensOnAuth(accessToken, refreshToken);
    state = const AsyncData(AuthMode.authenticated);
  }

  Future<void> logout() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.remove(_guestKey);
    await ref.read(authStorageProvider).deleteTokens();
    state = const AsyncData(AuthMode.unauthenticated);
    _invalidateProviders();
  }

  void _invalidateProviders() {
    ref.invalidate(categoryProvider);
    ref.invalidate(selectedCategoryProvider);
    // ref.invalidateSelf();
  }
}
