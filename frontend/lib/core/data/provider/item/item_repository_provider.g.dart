// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemRepository)
final itemRepositoryProvider = ItemRepositoryProvider._();

final class ItemRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ItemRepository>,
          ItemRepository,
          FutureOr<ItemRepository>
        >
    with $FutureModifier<ItemRepository>, $FutureProvider<ItemRepository> {
  ItemRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ItemRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ItemRepository> create(Ref ref) {
    return itemRepository(ref);
  }
}

String _$itemRepositoryHash() => r'a78b83625d31b620c54120c9dc5f7f651d696d17';
