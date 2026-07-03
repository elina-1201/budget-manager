import 'package:budget_manager/data/models/item.dart';
import 'package:budget_manager/data/repositories/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class ItemsListNotifier extends _$ItemsListNotifier {
  @override
  Future<List<Item>> build() async {
    final repository = await ref.watch(itemRepositoryProvider.future);
    return repository.getItems();
  }

  Future<void> deleteItem(int itemId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = await ref.read(itemRepositoryProvider.future);
      await repository.deleteItem(itemId: itemId);
      return repository.getItems(); // refresh the list
    });
  }
}
