// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryRepository)
final categoryRepositoryProvider = CategoryRepositoryProvider._();

final class CategoryRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<CategoryRepository>,
          CategoryRepository,
          FutureOr<CategoryRepository>
        >
    with
        $FutureModifier<CategoryRepository>,
        $FutureProvider<CategoryRepository> {
  CategoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<CategoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CategoryRepository> create(Ref ref) {
    return categoryRepository(ref);
  }
}

String _$categoryRepositoryHash() =>
    r'26ff174fa869fc6fc305d3faac521091f6d12743';
