import 'dart:ui';

import 'package:budget_manager/src/data/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_notifier.g.dart';

@riverpod
class SelectedCategoryNotifier extends _$SelectedCategoryNotifier {
  @override
  Category? build() => null;

  void select(Category? category) => state = category;
}

@riverpod
class SelectedDateNotifier extends _$SelectedDateNotifier {
  @override
  DateTime? build() => DateTime.now();

  void select(DateTime? date) => state = date;
}

@riverpod
class SelectedColorNotifier extends _$SelectedColorNotifier {
  @override
  Color? build() => null;

  void select(Color? color) => state = color;
}
