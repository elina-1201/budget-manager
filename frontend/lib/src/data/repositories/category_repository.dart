import 'dart:ui';

import 'package:budget_manager/src/data/models/category_db.dart';
import 'package:budget_manager/src/domain/models/category.dart';

abstract interface class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> saveCategory({required String categoryName});
  // Future<void> updateCategory({required Category category});
  Future<void> deleteCategory({required int categoryId});
}

mixin CategoryMapper {
  Category toDomain(CategoryDB local) => Category(
    id: local.id,
    name: local.name,
    color: local.color != null ? Color(local.color!) : null,
  );
}
