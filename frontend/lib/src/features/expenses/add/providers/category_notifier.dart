import 'package:budget_manager/src/data/models/category.dart';
import 'package:budget_manager/src/data/repositories/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_notifier.g.dart';

@Riverpod(keepAlive: true)
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Future<List<Category>> build() async {
    final repo = await ref.watch(categoryRepositoryProvider.future);
    return repo.getCategories();
  }

  Future<void> addCategory({required String name}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = await ref.read(categoryRepositoryProvider.future);
      await repo.saveCategory(categoryName: name);
      return repo.getCategories();
    });
  }

  Future<void> deleteCategory({required int id}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = await ref.read(categoryRepositoryProvider.future);
      await repo.deleteCategory(categoryId: id);
      return repo.getCategories();
    });
  }
}
