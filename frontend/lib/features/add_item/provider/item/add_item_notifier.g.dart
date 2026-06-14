// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddItemNotifier)
final addItemProvider = AddItemNotifierProvider._();

final class AddItemNotifierProvider
    extends $AsyncNotifierProvider<AddItemNotifier, void> {
  AddItemNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addItemProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addItemNotifierHash();

  @$internal
  @override
  AddItemNotifier create() => AddItemNotifier();
}

String _$addItemNotifierHash() => r'cf18ccd2d7f79a0c4ba9fde703dad5d3fd5bcbb5';

abstract class _$AddItemNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
