import 'package:budget_manager/core/http/dio_provider.dart';
import 'package:budget_manager/features/auth/data/register_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
RegisterRepository registerRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return RegisterRepository(dio: dio);
}
