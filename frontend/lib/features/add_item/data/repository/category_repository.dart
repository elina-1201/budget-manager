import 'package:budget_manager/features/add_item/data/dto/category.dart';
import 'package:dio/dio.dart';

class CategoryRepository {
  final Dio _dio;

  CategoryRepository({required this._dio});
  Future<List<Category>> getUsersCategories() async {
    final response = await _dio.get('/category');

    return (response.data as List).map((e) => Category.fromMap(e)).toList();
  }
}
