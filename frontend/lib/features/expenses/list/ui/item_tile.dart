import 'package:budget_manager/core/theme/app_colors.dart';
import 'package:budget_manager/data/models/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        DateTime.fromMillisecondsSinceEpoch(
          item.date ?? 0,
        ).day.toString().padLeft(2, '0'),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      title: Text(item.name),
      subtitle: (item.description != null && item.description!.isNotEmpty)
          ? Text(item.description!)
          : null,
      trailing: Text('${item.amount.toStringAsFixed(2)} KM'),
      onTap: () {
        context.push('/item_details/${item.id}');
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
