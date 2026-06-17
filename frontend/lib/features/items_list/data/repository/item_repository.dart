import 'package:dio/dio.dart';

import '../dto/item.dart';

class ItemRepository {
  final Dio _dio;
  final String baseUrl;
  ItemRepository({required this._dio, required this.baseUrl});

  Future<List<Item>> fetchItems() async {
    final response = await _dio.get('$baseUrl/item');

    return (response.data as List).map((e) => Item.fromMap(e)).toList();
  }

  Future<void> deleteItem(int itemId) async {
    await _dio.delete('$baseUrl/item/$itemId');
  }
}
