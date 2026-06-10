import 'package:budget_manager/core/services/auth/auth_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_storage_provider.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
AuthStorage authStorage(Ref ref) {
  return AuthStorage(ref.watch(flutterSecureStorageProvider));
}
