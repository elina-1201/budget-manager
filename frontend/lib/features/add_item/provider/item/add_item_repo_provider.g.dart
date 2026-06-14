// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addItemRepository)
final addItemRepositoryProvider = AddItemRepositoryProvider._();

final class AddItemRepositoryProvider
    extends
        $FunctionalProvider<
          AddItemRepository,
          AddItemRepository,
          AddItemRepository
        >
    with $Provider<AddItemRepository> {
  AddItemRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addItemRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addItemRepositoryHash();

  @$internal
  @override
  $ProviderElement<AddItemRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AddItemRepository create(Ref ref) {
    return addItemRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddItemRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddItemRepository>(value),
    );
  }
}

String _$addItemRepositoryHash() => r'bcd3e5bb50a9ec5a96f3099a5fa13a2c5e703568';
