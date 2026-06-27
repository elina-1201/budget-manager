import 'package:budget_manager/core/data/dto/item.dart';
import 'package:budget_manager/core/data/provider/item/item_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_provider.g.dart';

@riverpod
Future<Item> itemDetails(Ref ref, int itemId) async {
  final repository = ref.read(itemRepositoryProvider).requireValue;
  return await repository.getItem(itemId: itemId);
}
