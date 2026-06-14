import 'package:budget_manager/features/add_item/data/dto/item_request_body.dart';
import 'package:dio/dio.dart';

class AddItemRepository {
  final Dio _dio;
  final String baseUrl;

  AddItemRepository({required this._dio, required this.baseUrl});

  Future<void> addItem({required ItemRequestBody body}) async {
    await _dio.post('$baseUrl/item', data: body.toMap());
  }
}
