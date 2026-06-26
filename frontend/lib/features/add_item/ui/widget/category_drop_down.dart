import 'package:budget_manager/core/data/dto/category.dart';
import 'package:budget_manager/features/add_item/provider/category/category_notifier.dart';
import 'package:budget_manager/features/add_item/provider/category/selected_category_notifier.dart';
import 'package:budget_manager/features/add_item/ui/widget/drop_down.dart';
import 'package:budget_manager/shared/widget/modal_button/button_type.dart';
import 'package:budget_manager/shared/widget/modal_button/modal_text_button.dart';
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
      hintText: 'Select a category',
      onDelete: (Category item) => _deleteCategory(item),
    );
  }

  void _openAddCategoryModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          //TODO: clear the text field when the modal is closed
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Category Name'),
            controller: _categoryName,
          ),
          actions: [
            ModalTextButton(
              onPress: () {
                Navigator.of(context).pop();
              },
              label: 'Cancel',
              type: ButtonType.cancel,
            ),
            OutlinedButton(
              onPressed: () async {
                await _addCategory();
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCategory(Category category) async {
    final notifier = ref.read(categoryProvider.notifier);
    await notifier.deleteCategory(id: category.id);
    if (ref.read(selectedCategoryProvider) == category) {
      ref.read(selectedCategoryProvider.notifier).select(null);
    }
  }

  //TODO: add validation for duplicate category names
  Future<void> _addCategory() async {
    {
      final categoryName = _categoryName.text;
      if (categoryName.isNotEmpty) {
        Category newCategory = await ref
            .read(categoryProvider.notifier)
            .addCategory(name: categoryName)
            .then((categories) => categories.first);

        ref.read(selectedCategoryProvider.notifier).select(newCategory);
        _categoryName.clear();
      }
    }
  }
}
