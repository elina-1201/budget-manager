import 'package:budget_manager/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthHeader extends StatelessWidget {
  const MonthHeader({
    super.key,
    required this.year,
    required this.month,
    required this.total,
  });

  final int year;
  final int month;
  final double total;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final date = DateFormat('MMMM yyyy', locale).format(DateTime(year, month));
    final label = date[0].toUpperCase() + date.substring(1);
    final totalLabel = '${total.toStringAsFixed(2)} KM';

    return Container(
      color: Theme.of(
        context,
      ).scaffoldBackgroundColor, // opaque so tiles don't show through
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // label left, sum right
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 18, color: AppColors.bluish),
              ),
              Text(
                totalLabel,
                style: const TextStyle(fontSize: 16, color: AppColors.bluish),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
