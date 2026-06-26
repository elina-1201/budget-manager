import 'package:budget_manager/core/data/dto/category.dart';
import 'package:budget_manager/core/data/repository/category/category_repository_i.dart';
import 'package:sqflite/sqflite.dart';

class LocalCategoryRepo implements CategoryRepository {
  final Database db;
  LocalCategoryRepo({required this.db});

  static const String tableName = 'category';

  @override
  Future<List<Category>> getCategories() async {
    List<Map<String, dynamic>> maps = await (db).query(
      tableName,
      orderBy: 'id DESC',
    );
    return List.generate(maps.length, (index) {
      return Category.fromMap(maps[index]);
    });
  }

  @override
  Future<void> saveCategory({required String categoryName}) async {
    await (db).insert(tableName, {'name': categoryName});
  }

  @override
  Future<void> deleteCategory({required int categoryId}) async {
    await db.delete(tableName, where: 'id = ?', whereArgs: [categoryId]);
  }
}
