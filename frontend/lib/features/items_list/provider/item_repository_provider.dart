import 'package:budget_manager/core/config/base_url/api_base_url.dart';
import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/features/items_list/data/repository/item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_repository_provider.g.dart';

@riverpod
ItemRepository itemRepository(Ref ref) {
  return ItemRepository(
    dio: ref.watch(dioProvider),
    baseUrl: ref.watch(apiBaseUrlProvider),
  );
}
