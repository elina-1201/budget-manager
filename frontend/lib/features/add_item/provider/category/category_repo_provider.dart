import 'package:budget_manager/core/services/dio/dio_provider.dart';
import 'package:budget_manager/features/add_item/data/repository/category_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repo_provider.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CategoryRepository(dio: dio);
}
