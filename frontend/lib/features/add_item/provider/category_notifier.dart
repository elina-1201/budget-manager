// lib/features/add_item/provider/category_notifier.dart
import 'package:budget_manager/features/add_item/data/dto/category.dart';
import 'package:budget_manager/features/add_item/provider/category_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_notifier.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  List<Category> build() {
    return [];
  }

  Future<List<Category>> loadCategories() async {
    final repo = ref.read(categoryRepositoryProvider);
    state = await repo.getUsersCategories();
    return state;
  }

  // Optional helper to manually refresh
  Future<void> refresh() async => loadCategories();

  // Example of adding a new category locally
  void add(Category category) {
    state = [...state, category];
  }
}
