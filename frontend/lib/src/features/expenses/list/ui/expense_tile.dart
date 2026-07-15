import 'package:budget_manager/src/core/theme/app_colors.dart';
import 'package:budget_manager/src/domain/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.push('/expense_details/${expense.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 45,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    '${expense.date.day < 10 ? '0${expense.date.day}' : expense.date.day}',
                    style: const TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w100,
                      // color: AppColors.bluish,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expense.name, style: const TextStyle(fontSize: 17)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            expense.category.color?.withValues(alpha: 0.1) ??
                            AppColors.bluish.withValues(alpha: 0.1),
                        border: Border.all(
                          color: expense.category.color ?? AppColors.bluish,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            expense.category.name,
                            style: const TextStyle(
                              fontSize: 12,
                              // color: AppColors.goldPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              Center(
                child: Text(
                  '${expense.amount.toStringAsFixed(2)} KM',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
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
