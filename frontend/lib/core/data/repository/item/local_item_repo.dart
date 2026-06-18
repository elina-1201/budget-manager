import 'package:budget_manager/core/data/dto/item.dart';
import 'package:budget_manager/core/data/repository/item/item_repository_i.dart';
import 'package:budget_manager/features/add_item/data/dto/item_request_body.dart';

class LocalItemRepo implements ItemRepository {
  // LocalItemRepo(this._db);
  // final LocalDb _db;

  @override
  Future<List<Item>> getItems() {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  @override
  Future<void> saveItem({required ItemRequestBody body}) {
    // TODO: implement saveItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateItem({required ItemRequestBody body}) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem({required int itemId}) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }
}
