import 'package:budget_manager/data/models/category.dart';
import 'package:budget_manager/data/models/item.dart';
import 'package:budget_manager/data/models/item_request_body.dart';
import 'package:budget_manager/data/repositories/item_repository.dart';
import 'package:sqflite/sqflite.dart';

class ItemRepositoryLocal implements ItemRepository {
  final Database db;
  ItemRepositoryLocal({required this.db});

  static const String tableName = 'item';

  @override
  Future<List<Item>> getItems() async {
    final rows = await db.query(tableName, orderBy: 'date DESC');
    if (rows.isEmpty) return [];
    return rows.map((row) => Item.fromMap(row)).toList();
  }

  @override
  Future<void> saveItem({required ItemRequestBody body}) async {
    final rows = await db.query(
      'category',
      where: 'id = ?',
      whereArgs: [body.categoryId],
    );

    final Category category = rows.map((row) => Category.fromMap(row)).first;
    final int dateInMillis = body.date.millisecondsSinceEpoch;

    Item item = Item(
      name: body.name,
      description: body.description,
      amount: body.amount,
      category: category.name,
      date: dateInMillis,
    );

    await db.insert(tableName, item.toMap());
  }

  @override
  Future<void> updateItem({required ItemRequestBody body}) async {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem({required int itemId}) async {
    await db.delete(tableName, where: 'id = ?', whereArgs: [itemId]);
  }

  @override
  Future<Item> getItem({required int itemId}) async {
    final rows = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [itemId],
    );
    if (rows.isEmpty) {
      throw Exception('Item not found');
    }
    return Item.fromMap(rows.first);
  }
}
