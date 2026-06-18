import 'package:budget_manager/core/data/dto/item.dart';
import 'package:budget_manager/features/add_item/data/dto/item_request_body.dart';

abstract interface class ItemRepository {
  Future<List<Item>> getItems();
  Future<void> saveItem({required ItemRequestBody body});
  Future<void> deleteItem({required int itemId});
  Future<void> updateItem({required ItemRequestBody body});
}
