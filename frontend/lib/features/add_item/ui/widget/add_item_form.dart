import 'package:budget_manager/core/data/dto/category.dart';
import 'package:budget_manager/features/add_item/provider/category/category_notifier.dart';
import 'package:budget_manager/features/add_item/provider/category/selected_category_notifier.dart';
import 'package:budget_manager/features/add_item/provider/item/add_item_notifier.dart';
import 'package:budget_manager/features/add_item/ui/widget/drop_down.dart';
import 'package:budget_manager/features/items_list/provider/item_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItemForm extends ConsumerStatefulWidget {
  const AddItemForm({super.key});

  @override
  ConsumerState<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends ConsumerState<AddItemForm> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _amount;
  late final TextEditingController _categoryName;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
    _amount = TextEditingController();
    _categoryName = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _amount.dispose();
    _categoryName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addItemState = ref.watch(addItemProvider);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Item Name'),
            controller: _name,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Description'),
            controller: _description,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            controller: _amount,
          ),
          GenericDropDown<Category>(
            list: ref.watch(categoryProvider),
            selected: ref.watch(selectedCategoryProvider),
            onChanged: (Category? value) {
              ref.read(selectedCategoryProvider.notifier).select(value);
            },
            itemLabel: (Category c) => c.name,
          ),
          ElevatedButton(
            onPressed: () =>
                _addNewItem(ref, addItemState, _name, _description, _amount),
            child: addItemState.when(
              data: (data) => const Text('Add Item'),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),

          TextField(
            decoration: InputDecoration(labelText: 'Category'),
            controller: _categoryName,
          ),
          ElevatedButton(
            onPressed: () => _addCategory(),
            child: const Text('Add Category'),
          ),
        ],
      ),
    );
  }

  Future<void> _addCategory() async {
    {
      final categoryName = _categoryName.text;
      if (categoryName.isNotEmpty) {
        ref.read(categoryProvider.notifier).addCategory(name: categoryName);
        _categoryName.clear();
      }
    }
  }

  void _addNewItem(
    WidgetRef ref,
    AsyncValue addItemState,
    TextEditingController name,
    TextEditingController description,
    TextEditingController amount,
  ) async {
    try {
      await ref
          .read(addItemProvider.notifier)
          .addItem(
            name: name.text,
            description: description.text,
            amount: double.tryParse(amount.text) ?? 0.0,
            categoryId: ref.read(selectedCategoryProvider)?.id ?? 0,
          );
      await ref.read(itemsListProvider.notifier).refresh();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Added successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add item: $e')));
    }
    name.clear();
    description.clear();
    amount.clear();
  }
}
