import 'package:budget_manager/core/data/dto/category.dart';

abstract interface class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> saveCategory({required String categoryName});
  Future<void> updateCategory({required Category category});
  Future<void> deleteCategory({required int categoryId});
}
