import 'package:budget_manager/features/expenses/add/providers/add_item_notifier.dart';
import 'package:budget_manager/features/expenses/add/providers/selected_category_notifier.dart';
import 'package:budget_manager/features/expenses/add/ui/category_drop_down.dart';
import 'package:budget_manager/features/expenses/list/providers/item_list_notifier.dart';
import 'package:budget_manager/shared/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItemForm extends ConsumerStatefulWidget {
  const AddItemForm({super.key});

  @override
  ConsumerState<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends ConsumerState<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _amount;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
    _amount = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addItemState = ref.watch(addItemProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 44.0, 16.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16.0,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Item Name'),
                controller: _name,
                validator: Validator.required(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                controller: _description,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: _amount,
                validator: Validator.positiveNumber(),
              ),
              CategoryDropDown(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addNewItem(ref, addItemState);
                  }
                },
                child: addItemState.when(
                  data: (data) => const Text('Add'),
                  error: (error, stackTrace) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addNewItem(WidgetRef ref, AsyncValue addItemState) async {
    try {
      await ref
          .read(addItemProvider.notifier)
          .addItem(
            name: _name.text,
            description: _description.text,
            //TODO: handle the case when the amount is not a valid double, add exception handling
            amount: double.tryParse(_amount.text) ?? 0.0,
            categoryId: ref.read(selectedCategoryProvider)?.id ?? 0,
          );
      ref.invalidate(itemsListProvider);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Added successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add item: $e')));
    }
    _name.clear();
    _description.clear();
    _amount.clear();
  }
}
