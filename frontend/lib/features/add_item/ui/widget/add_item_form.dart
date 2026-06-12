import 'package:budget_manager/features/add_item/data/dto/category.dart';
import 'package:budget_manager/features/add_item/provider/category_notifier.dart';
import 'package:budget_manager/features/add_item/provider/selected_category_notifier.dart';
import 'package:budget_manager/features/add_item/ui/widget/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: 'Item Name')),
          TextField(decoration: InputDecoration(labelText: 'Description')),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          Consumer(
            builder: (context, ref, child) {
              final categories = ref.watch(categoryProvider);
              return GenericDropDown<Category>(
                list: categories,
                selected: ref.watch(selectedCategoryProvider),
                onChanged: (Category? value) {
                  ref.read(selectedCategoryProvider.notifier).select(value);
                },
                itemLabel: (Category c) => c.name,
              );
            },
          ),
          ElevatedButton(onPressed: () {}, child: Text('Add Item')),
        ],
      ),
    );
  }
}
