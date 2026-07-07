import 'package:budget_manager/src/core/exceptions/error_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_mapper_provider.g.dart';

@riverpod
ErrorMapper errorMapper(Ref ref) => const ErrorMapper();
