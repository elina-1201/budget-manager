import 'package:budget_manager/data/models/item.dart';
import 'package:budget_manager/data/models/item_request_body.dart';
import 'package:budget_manager/data/repositories/item_repository.dart';
import 'package:dio/dio.dart';

class ItemRepositoryRemote implements ItemRepository {
  final Dio _dio;
  ItemRepositoryRemote({required this._dio});

  @override
  Future<List<Item>> getItems() async {
    final response = await _dio.get('/item');

    return (response.data as List).map((e) => Item.fromMap(e)).toList();
  }

  @override
  Future<void> saveItem({required ItemRequestBody body}) async {
    await _dio.post('/item', data: body.toMap());
  }

  @override
  Future<void> updateItem({required ItemRequestBody body}) async {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem({required int itemId}) async {
    await _dio.delete('/item/$itemId');
  }

  @override
  Future<Item> getItem({required int itemId}) {
    // TODO: implement getItem
    throw UnimplementedError();
  }
}
