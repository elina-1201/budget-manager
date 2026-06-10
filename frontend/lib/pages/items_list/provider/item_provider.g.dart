// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemsList)
final itemsListProvider = ItemsListProvider._();

final class ItemsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Item>>,
          List<Item>,
          FutureOr<List<Item>>
        >
    with $FutureModifier<List<Item>>, $FutureProvider<List<Item>> {
  ItemsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemsListHash();

  @$internal
  @override
  $FutureProviderElement<List<Item>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Item>> create(Ref ref) {
    return itemsList(ref);
  }
}

String _$itemsListHash() => r'e8f721ecead011fc8cbc2a88c5f84988474cc8d7';
