import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/core/exceptions/error_mapper.dart';
import 'package:budget_manager/src/domain/models/category.dart';
import 'package:budget_manager/src/features/expenses/add/providers/category_notifier.dart';
import 'package:budget_manager/src/features/expenses/add/providers/selected_notifier.dart';
import 'package:budget_manager/src/features/expenses/add/ui/color_picker.dart';
import 'package:budget_manager/src/features/expenses/add/ui/drop_down.dart';
import 'package:budget_manager/src/shared/widgets/modal/modal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDropDown extends ConsumerStatefulWidget {
  const CategoryDropDown({super.key});

  @override
  ConsumerState<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends ConsumerState<CategoryDropDown> {
  late final TextEditingController _categoryName;

  @override
  void initState() {
    super.initState();
    _categoryName = TextEditingController();
  }

  @override
  void dispose() {
    _categoryName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for category operation errors globally
    ref.listen<AsyncValue<List<Category>>>(categoryProvider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(const ErrorMapper().map(error).message)),
            );
          }
        },
      );
    });
    final s = S.of(context);

    return GenericDropDown<Category>(
      list: ref.watch(categoryProvider),
      selected: ref.watch(selectedCategoryProvider),
      onChanged: (Category? value) {
        ref.read(selectedCategoryProvider.notifier).select(value);
      },
      itemLabel: (Category c) => c.name,
      onAddRequest: () {
        _openAddCategoryModal();
      },
      hintText: s.select_category,
      onDelete: (Category item) => _deleteCategory(item),
    );
  }

  void _openAddCategoryModal() {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(s.add_new_category),
          content: Row(
            children: [
              CustomColorPicker(),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: s.category_name),
                  controller: _categoryName,
                ),
              ),
            ],
          ),
          actions: [
            ModalTextButton(
              onPress: () {
                Navigator.of(dialogContext).pop();
              },
              label: s.cancel,
              type: ButtonType.cancel,
            ),
            ModalOutlinedButton(
              onPress: () async {
                await _addCategory(dialogContext);
              },
              label: S.of(context).add,
            ),
          ],
        );
      },
    ).whenComplete(() => _categoryName.clear());
  }

  Future<void> _deleteCategory(Category category) async {
    final notifier = ref.read(categoryProvider.notifier);
    await notifier.deleteCategory(id: category.id);
    if (ref.read(selectedCategoryProvider) == category) {
      ref.read(selectedCategoryProvider.notifier).select(null);
    }
  }

  //TODO: check same name category exists before adding
  Future<void> _addCategory(BuildContext dialogContext) async {
    final categoryName = _categoryName.text.trim();
    if (categoryName.isEmpty) return;

    await ref.read(categoryProvider.notifier).addCategory(name: categoryName);

    // Only close the dialog and select the category if the operation succeeded
    final currentState = ref.read(categoryProvider);
    if (!currentState.hasError && currentState.hasValue) {
      final categories = currentState.value!;
      if (categories.isNotEmpty && dialogContext.mounted) {
        ref.read(selectedCategoryProvider.notifier).select(categories.first);
        Navigator.of(dialogContext).pop();
      }
    }
  }
}
