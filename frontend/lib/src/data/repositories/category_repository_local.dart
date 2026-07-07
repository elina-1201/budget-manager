import 'package:budget_manager/src/data/models/category_db.dart';
import 'package:budget_manager/src/data/repositories/category_repository.dart';
import 'package:budget_manager/src/domain/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepositoryLocal
    with CategoryMapper
    implements CategoryRepository {
  final Database db;
  CategoryRepositoryLocal({required this.db});

  static const String tableName = 'category';

  @override
  Future<List<Category>> getCategories() async {
    final rows = await db.query(tableName, orderBy: 'id DESC');
    if (rows.isEmpty) return [];
    return rows.map((row) => toDomain(CategoryDB.fromMap(row))).toList();
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
