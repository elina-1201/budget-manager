import 'package:budget_manager/core/data/repository/category/category_repository_i.dart';
import 'package:budget_manager/core/data/repository/category/local_category_repo.dart';
import 'package:budget_manager/core/data/repository/category/remote_category_repo.dart';
import 'package:budget_manager/core/services/auth/auth_mode_enum.dart';
import 'package:budget_manager/core/services/auth/storage/provider/auth_state_provider.dart';
import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/core/services/local_db/provider/local_db_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository_provider.g.dart';

@riverpod
Future<CategoryRepository> categoryRepository(Ref ref) async {
  final mode = ref.watch(authStateProvider).asData?.value;
  if (mode == AuthMode.authenticated) {
    return RemoteCategoryRepo(dio: ref.watch(dioProvider));
  }
  final db = await ref.watch(databaseConnectionProvider.future);
  return LocalCategoryRepo(db: db);
}
