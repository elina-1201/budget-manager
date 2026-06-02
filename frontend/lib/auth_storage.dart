// auth_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // Access token
  static Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  static Future<String?> getAccessToken() =>
      _storage.read(key: _accessTokenKey);

  // Refresh token
  static Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  static Future<String?> getRefreshToken() =>
      _storage.read(key: _refreshTokenKey);

  // Save both at once (handy for login)
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  // Clear both on logout
  static Future<void> deleteTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
