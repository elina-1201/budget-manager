import 'package:budget_manager/features/add_item/data/dto/category.dart';
import 'package:dio/dio.dart';

class CategoryRepository {
  final Dio _dio;
  final String _baseUrl;

  CategoryRepository({required this._dio, required this._baseUrl});
  Future<List<Category>> getUsersCategories() async {
    final response = await _dio.get('$_baseUrl/category');
    final data = response.data as List<dynamic>;
    return data
        .map(
          (e) => Category(
            id: (e['id'] as num).toInt(),
            name: e['name'] as String,
          ),
        )
        .toList();
  }
}
