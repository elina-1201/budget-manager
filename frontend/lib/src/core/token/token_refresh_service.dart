import 'dart:async';

import 'package:budget_manager/src/core/storage/auth_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TokenRefreshService {
  final AuthStorage _authStorage;
  final Dio Function() _dioFactory;
  Completer<bool>? _refreshLock;

  TokenRefreshService({required this._authStorage, required this._dioFactory});

  Future<bool> refreshToken() async {
    if (_refreshLock != null) {
      return _refreshLock!.future;
    }
    _refreshLock = Completer<bool>();

    try {
      final refreshToken = await _authStorage.getRefreshToken();
      if (refreshToken == null) {
        await _authStorage.deleteTokens();
        _refreshLock!.complete(false);
        return false;
      }

      final refreshDio = _dioFactory();
      final response = await refreshDio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      await _authStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      _refreshLock!.complete(true);
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('🔴 Token refresh failed: $e');
      }
      await _authStorage.deleteTokens();
      _refreshLock!.complete(false);
      return false;
    } finally {
      _refreshLock = null;
    }
  }
}
