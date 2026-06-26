import 'package:budget_manager/core/data/dto/item.dart';
import 'package:budget_manager/features/items_list/provider/item_list_notifier.dart';
import 'package:budget_manager/shared/widget/modal_button/button_type.dart';
import 'package:budget_manager/shared/widget/modal_button/modal_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertOnDelete extends ConsumerWidget {
  final Item item;
  const AlertOnDelete({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        ModalTextButton(
          onPress: () => Navigator.of(context).pop(false),
          label: "CANCEL",
          type: ButtonType.cancel,
        ),
        ModalTextButton(
          onPress: () async {
            await _deleteItem(item, context, ref);
          },
          label: "DELETE",
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
    ref.invalidate(itemsListProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${item.name}" deleted successfully')),
      );
    }
    Navigator.of(context).pop(true);
  }
}
