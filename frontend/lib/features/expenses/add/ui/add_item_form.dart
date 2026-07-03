import 'package:budget_manager/core/exceptions/async_error_listener.dart';
import 'package:budget_manager/features/expenses/add/providers/add_item_notifier.dart';
import 'package:budget_manager/features/expenses/add/providers/selected_category_notifier.dart';
import 'package:budget_manager/features/expenses/add/ui/category_drop_down.dart';
import 'package:budget_manager/features/expenses/add/ui/date_picker.dart';
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
  late final TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
    _amount = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _amount.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addItemState = ref.watch(addItemProvider);
    ref.listenAsyncError(addItemProvider, context: context);
    ref.listen<AsyncValue<void>>(addItemProvider, (_, next) {
      next.whenOrNull(
        data: (_) {
          ref.invalidate(itemsListProvider);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Added successfully')));
          _clearFormFields();
        },
      );
    });

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 44.0, 16.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 14.0,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
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
              DatePicker(controller: _dateController),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addNewItem();
                  }
                },
                child: addItemState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addNewItem() {
    final amountText = _amount.text.replaceAll(',', '.');
    final amount = double.parse(amountText);

    final categoryId = ref.read(selectedCategoryProvider)?.id;
    if (categoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    ref
        .read(addItemProvider.notifier)
        .addItem(
          name: _name.text,
          description: _description.text,
          amount: amount,
          categoryId: categoryId,
          date: DateTime.parse(
            _dateController.text.split('.').reversed.join('-'),
          ),
        );
  }

  void _clearFormFields() {
    _name.clear();
    _description.clear();
    _amount.clear();
  }
}
