import 'package:budget_manager/data/models/category.dart';
import 'package:budget_manager/data/repositories/category_repository.dart';
import 'package:dio/dio.dart';

class CategoryRepositoryRemote implements CategoryRepository {
  final Dio _dio;
  CategoryRepositoryRemote({required this._dio});

  @override
  Future<List<Category>> getCategories() async {
    final response = await _dio.get('/category');
    return (response.data as List).map((e) => Category.fromMap(e)).toList();
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
