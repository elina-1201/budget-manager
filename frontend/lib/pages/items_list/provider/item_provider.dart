import 'package:budget_manager/pages/items_list/provider/item_repository_provider.dart';
import 'package:budget_manager/pages/items_list/dto/item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_provider.g.dart';

@riverpod
Future<List<Item>> itemsList(Ref ref) async {
  final repository = ref.watch(itemRepositoryProvider);
  return repository.fetchItems();
}
