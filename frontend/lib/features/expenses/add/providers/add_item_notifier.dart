import 'package:budget_manager/data/models/item_request_body.dart';
import 'package:budget_manager/data/repositories/repository_providers.dart';
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
      final repo = await ref.read(itemRepositoryProvider.future);
      await repo.saveItem(
        body: ItemRequestBody(
          name: name,
          description: description,
          amount: amount,
          categoryId: categoryId,
        ),
      );
    });
  }
}
