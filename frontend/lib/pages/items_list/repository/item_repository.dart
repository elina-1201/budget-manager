import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../dto/item.dart';

class ItemRepository {
  ItemRepository({required this._dio});
  final Dio _dio;

  Future<List<Item>> fetchItems() async {
    final baseUrl = GetIt.I.get<String>();
    final response = await _dio.get('$baseUrl/item');

    return (response.data as List).map((e) => Item.fromMap(e)).toList();
  }
}
