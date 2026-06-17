import 'package:budget_manager/features/add_item/data/dto/category.dart';
import 'package:dio/dio.dart';

class CategoryRepository {
  final Dio _dio;
  final String _baseUrl;

  CategoryRepository({required this._dio, required this._baseUrl});
  Future<List<Category>> getUsersCategories() async {
    final response = await _dio.get('$_baseUrl/category');

    return (response.data as List).map((e) => Category.fromMap(e)).toList();
  }
}
