import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:budget_manager/di/auth_storage.dart';
import '../dto/item.dart';

class ItemRepository {
  final Dio dio;
  ItemRepository({required this.dio});

  Future<List<Item>> fetchItems() async {
    final token = await GetIt.I.get<AuthStorage>().getAccessToken();

    final baseUrl = GetIt.I.get<String>();
    final response = await dio.get(
      '$baseUrl/item',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return (response.data as List).map((e) => Item.fromMap(e)).toList();
  }
}
