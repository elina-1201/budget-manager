import 'package:budget_manager/core/data/dto/item.dart';
import 'package:budget_manager/core/data/provider/item/item_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_list_notifier.g.dart';

@riverpod
class ItemsListNotifier extends _$ItemsListNotifier {
  @override
  Future<List<Item>> build() async {
    final repository = ref.watch(itemRepositoryProvider);
    return repository.getItems();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.watch(itemRepositoryProvider);
      return repository.getItems();
    });
  }

  Future<void> deleteItem(int itemId) async {
    final repository = ref.watch(itemRepositoryProvider);
    await repository.deleteItem(itemId: itemId);
  }
}
