import 'package:budget_manager/core/data/dto/category.dart';
import 'package:budget_manager/core/data/provider/category_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_notifier.g.dart';

@Riverpod(keepAlive: true)
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Future<List<Category>> build() async {
    return await _loadCategories();
  }

  Future<List<Category>> _loadCategories() async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(categoryRepositoryProvider);
      return await repo.getCategories();
    });
    return state.value ?? [];
  }

  void addCategory({required String name}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(categoryRepositoryProvider);
      await repo.saveCategory(categoryName: name);
      return await _loadCategories();
    });
  }
}
