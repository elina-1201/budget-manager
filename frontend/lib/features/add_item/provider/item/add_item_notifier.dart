import 'package:budget_manager/features/add_item/data/dto/item_request_body.dart';
import 'package:budget_manager/features/add_item/provider/item/add_item_repo_provider.dart';
import 'package:budget_manager/features/items_list/provider/item_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_item_notifier.g.dart';

@riverpod
class AddItemNotifier extends _$AddItemNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> addItem({
    required String name,
    required String description,
    required double amount,
    required int categoryId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(addItemRepositoryProvider)
          .addItem(
            body: ItemRequestBody(
              name: name,
              description: description,
              amount: amount,
              categoryId: categoryId,
            ),
          );
      await ref.read(itemsListProvider.notifier).refresh();
    });
  }
}
