import 'package:budget_manager/features/expenses/add/ui/add_expense_form.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: AddExpenseForm(),
    );
  }
}
