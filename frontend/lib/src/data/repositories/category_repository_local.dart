import 'package:budget_manager/src/data/models/category.dart';
import 'package:budget_manager/src/data/repositories/category_repository.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepositoryLocal implements CategoryRepository {
  final Database db;
  CategoryRepositoryLocal({required this.db});

  static const String tableName = 'category';

  @override
  Future<List<Category>> getCategories() async {
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'id DESC',
    );
    return List.generate(maps.length, (index) {
      return Category.fromMap(maps[index]);
    });
  }

  @override
  Future<void> saveCategory({required String categoryName}) async {
    await db.insert(tableName, {'name': categoryName});
  }

  @override
  Future<void> deleteCategory({required int categoryId}) async {
    await db.delete(tableName, where: 'id = ?', whereArgs: [categoryId]);
  }
}
