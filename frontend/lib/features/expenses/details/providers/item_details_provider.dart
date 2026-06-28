import 'package:budget_manager/data/models/item.dart';
import 'package:budget_manager/data/repositories/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_details_provider.g.dart';

@riverpod
Future<Item> itemDetails(Ref ref, int itemId) async {
  final repository = ref.read(itemRepositoryProvider).requireValue;
  return await repository.getItem(itemId: itemId);
}
