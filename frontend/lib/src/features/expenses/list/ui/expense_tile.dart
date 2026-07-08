import 'package:budget_manager/src/core/theme/app_colors.dart';
import 'package:budget_manager/src/domain/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${expense.date.day}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      title: Text(expense.name),
      subtitle: Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: expense.category.color ?? AppColors.backgroundDark,
          ),
          const SizedBox(width: 5),
          Text(expense.category.name),
        ],
      ),
      trailing: Text('${expense.amount.toStringAsFixed(2)} KM'),
      onTap: () {
        context.push('/expense_details/${expense.id}');
      },
    );
  }
}

class DeleteBackground extends StatelessWidget {
  const DeleteBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20.0),
      color: AppColors.backgroundDelete,
      alignment: Alignment.centerRight,
      child: Icon(Icons.delete_outlined, color: Colors.white),
    );
  }
}
