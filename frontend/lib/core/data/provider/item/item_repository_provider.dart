import 'package:budget_manager/core/data/repository/item/item_repository_i.dart';
import 'package:budget_manager/core/data/repository/item/local_item_repo.dart';
import 'package:budget_manager/core/data/repository/item/remote_item_repo.dart';
import 'package:budget_manager/core/services/auth/auth_mode_enum.dart';
import 'package:budget_manager/core/services/auth/storage/provider/auth_state_provider.dart';
import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/core/services/local_db/provider/local_db_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_repository_provider.g.dart';

@riverpod
ItemRepository itemRepository(Ref ref) {
  final mode = ref.watch(authStateProvider).asData?.value;
  return mode == AuthMode.authenticated
      ? RemoteItemRepo(dio: ref.watch(dioProvider))
      : LocalItemRepo(db: ref.watch(databaseConnectionProvider).requireValue);
}
