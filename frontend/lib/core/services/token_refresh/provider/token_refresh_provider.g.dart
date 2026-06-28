// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tokenRefresh)
final tokenRefreshProvider = TokenRefreshProvider._();

final class TokenRefreshProvider
    extends
        $FunctionalProvider<
          TokenRefreshService,
          TokenRefreshService,
          TokenRefreshService
        >
    with $Provider<TokenRefreshService> {
  TokenRefreshProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenRefreshProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenRefreshHash();

  @$internal
  @override
  $ProviderElement<TokenRefreshService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TokenRefreshService create(Ref ref) {
    return tokenRefresh(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenRefreshService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenRefreshService>(value),
    );
  }
}

String _$tokenRefreshHash() => r'b39e7e2e3b8656bcd7df1b0491c4df4dbe40bbb9';
