import 'package:budget_manager/features/add_item/data/dto/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_category_notifier.g.dart';

@riverpod
class SelectedCategoryNotifier extends _$SelectedCategoryNotifier {
  @override
  Category? build() => null;

  void select(Category? category) => state = category;
}
