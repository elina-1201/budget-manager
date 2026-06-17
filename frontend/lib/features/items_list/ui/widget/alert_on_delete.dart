import 'package:budget_manager/features/items_list/data/dto/item.dart';
import 'package:budget_manager/features/items_list/provider/item_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertOnDelete extends ConsumerWidget {
  final Item item;
  const AlertOnDelete({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final item = ModalRoute.of(context)!.settings.arguments as Item;
    return AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("CANCEL"),
        ),
        TextButton(
          onPressed: () async {
            await _deleteItem(item, context, ref);
          },
          child: const Text(
            "DELETE",
            style: TextStyle(color: Color.fromARGB(255, 133, 27, 19)),
          ),
        ),
      ],
    );
  }

  Future<void> _deleteItem(
    Item item,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final notifier = ref.read(itemsListProvider.notifier);
    await notifier.deleteItem(item.id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${item.name}" deleted successfully')),
      );
    }
    Navigator.of(context).pop(true);
  }
}
