// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ItemsListNotifier)
final itemsListProvider = ItemsListNotifierProvider._();

final class ItemsListNotifierProvider
    extends $AsyncNotifierProvider<ItemsListNotifier, List<Item>> {
  ItemsListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemsListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemsListNotifierHash();

  @$internal
  @override
  ItemsListNotifier create() => ItemsListNotifier();
}

String _$itemsListNotifierHash() => r'ab9a4736b9e398b6ad50b722568788f374f8c9af';

abstract class _$ItemsListNotifier extends $AsyncNotifier<List<Item>> {
  FutureOr<List<Item>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Item>>, List<Item>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Item>>, List<Item>>,
              AsyncValue<List<Item>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
