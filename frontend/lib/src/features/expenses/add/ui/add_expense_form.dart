import 'package:budget_manager/src/core/exceptions/async_error_listener.dart';
import 'package:budget_manager/src/features/expenses/add/providers/add_expense_notifier.dart';
import 'package:budget_manager/src/features/expenses/add/providers/selected_category_notifier.dart';
import 'package:budget_manager/src/features/expenses/add/ui/category_drop_down.dart';
import 'package:budget_manager/src/features/expenses/add/ui/date_picker.dart';
import 'package:budget_manager/src/features/expenses/list/providers/expense_list_notifier.dart';
import 'package:budget_manager/src/shared/validator/validator.dart';
import 'package:budget_manager/src/shared/widgets/clearable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseForm extends ConsumerStatefulWidget {
  const AddExpenseForm({super.key});

  @override
  ConsumerState<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends ConsumerState<AddExpenseForm> {
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
    final addExpenseState = ref.watch(addExpenseProvider);
    ref.listenAsyncError(addExpenseProvider, context: context);
    ref.listen<AsyncValue<void>>(addExpenseProvider, (_, next) {
      next.whenOrNull(
        data: (_) {
          ref.invalidate(expensesListProvider);
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
              ClearableTextField(
                controller: _name,
                labelText: 'Name',
                validator: Validator.required(),
              ),
              ClearableTextField(
                controller: _description,
                labelText: 'Description',
              ),
              ClearableTextField(
                controller: _amount,
                labelText: 'Amount',
                keyboardType: TextInputType.number,
                validator: Validator.positiveNumber(),
              ),
              CategoryDropDown(),
              DatePicker(controller: _dateController),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addNewExpense();
                  }
                },
                child: addExpenseState.isLoading
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

  void _addNewExpense() {
    final amountText = _amount.text.replaceAll(',', '.');
    final amount = double.parse(amountText);
    final DateTime selectedDate = DateTime.parse(
      _dateController.text.split('.').reversed.join('-'),
    );

    final categoryId = ref.read(selectedCategoryProvider)?.id;
    if (categoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    ref
        .read(addExpenseProvider.notifier)
        .addExpense(
          name: _name.text,
          description: _description.text,
          amount: amount,
          categoryId: categoryId,
          date: selectedDate,
        );
  }

  void _clearFormFields() {
    _name.clear();
    _description.clear();
    _amount.clear();
  }
}
