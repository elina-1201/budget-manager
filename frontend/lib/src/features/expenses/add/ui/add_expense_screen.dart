import 'package:budget_manager/generated/l10n.dart';
import 'package:budget_manager/src/features/expenses/add/ui/add_expense_form.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).add_expense)),
      body: AddExpenseForm(),
    );
  }
}
