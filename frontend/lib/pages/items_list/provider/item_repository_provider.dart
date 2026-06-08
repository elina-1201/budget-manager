import 'package:budget_manager/pages/items_list/repository/item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_repository_provider.g.dart';

@riverpod
ItemRepository itemRepository(_) {
  return ItemRepository();
}
