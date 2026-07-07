import 'package:budget_manager/src/data/models/category.dart';

abstract interface class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> saveCategory({required String categoryName});
  // Future<void> updateCategory({required Category category});
  Future<void> deleteCategory({required int categoryId});
}
