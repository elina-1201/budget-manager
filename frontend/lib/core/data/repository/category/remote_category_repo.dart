import 'package:budget_manager/core/data/dto/category.dart';
import 'package:budget_manager/core/data/repository/category/category_repository_i.dart';
import 'package:dio/dio.dart';

class RemoteCategoryRepo implements CategoryRepository {
  final Dio _dio;
  RemoteCategoryRepo({required this._dio});

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
