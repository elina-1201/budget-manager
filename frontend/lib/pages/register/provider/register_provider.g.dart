// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(registerRepository)
final registerRepositoryProvider = RegisterRepositoryProvider._();

final class RegisterRepositoryProvider
    extends
        $FunctionalProvider<
          RegisterRepository,
          RegisterRepository,
          RegisterRepository
        >
    with $Provider<RegisterRepository> {
  RegisterRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerRepositoryHash();

  @$internal
  @override
  $ProviderElement<RegisterRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterRepository create(Ref ref) {
    return registerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterRepository>(value),
    );
  }
}

String _$registerRepositoryHash() =>
    r'9f7d1d26cbe324a0b64c20972c00bac487acc416';
