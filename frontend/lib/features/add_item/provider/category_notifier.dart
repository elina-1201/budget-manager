import 'package:budget_manager/features/add_item/data/dto/category.dart';
import 'package:budget_manager/features/add_item/provider/category_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_notifier.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Future<List<Category>> build() async {
    return await _loadCategories();
  }

  Future<List<Category>> _loadCategories() async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(categoryRepositoryProvider);
      return await repo.getUsersCategories();
    });
    return state.value ?? [];
  }

  // @override
  // void update(List<Category> categories) {
  //   state = [...categories];
  // }

  // // Optional helper to manually refresh
  // Future<void> refresh() async => _loadCategories();

  // // Example of adding a new category locally
  // void add(Category category) {
  //   state = [...state, category];
  // }
}
