import 'package:budget_manager/src/data/models/category_db.dart';
import 'package:budget_manager/src/data/repositories/category_repository.dart';
import 'package:budget_manager/src/domain/models/category.dart';
import 'package:dio/dio.dart';

class CategoryRepositoryRemote
    with CategoryMapper
    implements CategoryRepository {
  final Dio _dio;
  CategoryRepositoryRemote({required this._dio});

  @override
  Future<List<Category>> getCategories() async {
    final response = await _dio.get('/category');

    return (response.data as List)
        .map((e) => toDomain(CategoryDB.fromMap(e)))
        .toList();
  }

  @override
  Future<void> saveCategory({required String categoryName}) async {
    await _dio.post('/category', data: {'name': categoryName});
  }

  @override
  Future<void> deleteCategory({required int categoryId}) async {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }
}
