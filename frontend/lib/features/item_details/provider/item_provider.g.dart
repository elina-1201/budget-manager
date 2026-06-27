// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemDetails)
final itemDetailsProvider = ItemDetailsFamily._();

final class ItemDetailsProvider
    extends $FunctionalProvider<AsyncValue<Item>, Item, FutureOr<Item>>
    with $FutureModifier<Item>, $FutureProvider<Item> {
  ItemDetailsProvider._({
    required ItemDetailsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'itemDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$itemDetailsHash();

  @override
  String toString() {
    return r'itemDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Item> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Item> create(Ref ref) {
    final argument = this.argument as int;
    return itemDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$itemDetailsHash() => r'49c1d1eaa99023ff16b1e2b431a64a333449378e';

final class ItemDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Item>, int> {
  ItemDetailsFamily._()
    : super(
        retry: null,
        name: r'itemDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ItemDetailsProvider call(int itemId) =>
      ItemDetailsProvider._(argument: itemId, from: this);

  @override
  String toString() => r'itemDetailsProvider';
}
