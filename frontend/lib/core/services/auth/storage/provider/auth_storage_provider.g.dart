// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(flutterSecureStorage)
final flutterSecureStorageProvider = FlutterSecureStorageProvider._();

final class FlutterSecureStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorage,
          FlutterSecureStorage,
          FlutterSecureStorage
        >
    with $Provider<FlutterSecureStorage> {
  FlutterSecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flutterSecureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flutterSecureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return flutterSecureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$flutterSecureStorageHash() =>
    r'74fc6ea2bb3b1f668a5f3e4f549614146c526484';

@ProviderFor(authStorage)
final authStorageProvider = AuthStorageProvider._();

final class AuthStorageProvider
    extends $FunctionalProvider<AuthStorage, AuthStorage, AuthStorage>
    with $Provider<AuthStorage> {
  AuthStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStorageHash();

  @$internal
  @override
  $ProviderElement<AuthStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthStorage create(Ref ref) {
    return authStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStorage>(value),
    );
  }
}

String _$authStorageHash() => r'6a57769b31ecccc76a1d9773da2eb4b0492339d9';
