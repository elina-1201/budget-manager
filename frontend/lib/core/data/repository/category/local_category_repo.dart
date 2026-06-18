import 'package:budget_manager/core/data/dto/category.dart';
import 'package:budget_manager/core/data/repository/category/category_repository_i.dart';

class LocalCategoryRepo implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<void> saveCategory({required String categoryName}) {
    // TODO: implement saveCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory({required Category category}) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory({required int categoryId}) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }
}
