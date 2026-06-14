import 'package:budget_manager/core/services/auth/storage/provider/auth_state_provider.dart';
import 'package:budget_manager/features/items_list/data/dto/item.dart';
import 'package:budget_manager/features/items_list/provider/item_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_list_notifier.g.dart';

@riverpod
class ItemsListNotifier extends _$ItemsListNotifier {
  @override
  Future<List<Item>> build() async {
    await ref.watch(authStateProvider.future);
    final repository = ref.watch(itemRepositoryProvider);
    return repository.fetchItems();
  }

  Future<void> refresh() async {
    // state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.watch(itemRepositoryProvider);
      return repository.fetchItems();
    });
  }
}
