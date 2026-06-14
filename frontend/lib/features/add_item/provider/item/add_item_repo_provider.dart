import 'package:budget_manager/core/config/base_url/api_base_url.dart';
import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/features/add_item/data/repository/add_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_item_repo_provider.g.dart';

@riverpod
AddItemRepository addItemRepository(Ref ref) {
  return AddItemRepository(
    dio: ref.read(dioProvider),
    baseUrl: ref.read(apiBaseUrlProvider),
  );
}
