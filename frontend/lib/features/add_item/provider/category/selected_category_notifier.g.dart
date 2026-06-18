// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_category_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedCategoryNotifier)
final selectedCategoryProvider = SelectedCategoryNotifierProvider._();

final class SelectedCategoryNotifierProvider
    extends $NotifierProvider<SelectedCategoryNotifier, Category?> {
  SelectedCategoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCategoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCategoryNotifierHash();

  @$internal
  @override
  SelectedCategoryNotifier create() => SelectedCategoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Category? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Category?>(value),
    );
  }
}

String _$selectedCategoryNotifierHash() =>
    r'3368c2d89d5ea6c57f7c96152636362225376740';

abstract class _$SelectedCategoryNotifier extends $Notifier<Category?> {
  Category? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Category?, Category?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Category?, Category?>,
              Category?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
