import 'package:budget_manager/core/exceptions/error_mapper.dart';
import 'package:budget_manager/data/models/item.dart';
import 'package:budget_manager/features/expenses/list/providers/item_list_notifier.dart';
import 'package:budget_manager/shared/widgets/modal/button_type.dart';
import 'package:budget_manager/shared/widgets/modal/modal_text_button.dart';
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
          type: ButtonType.delete,
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
    await notifier.deleteItem(item.id!);

    if (context.mounted) {
      final currentState = ref.read(itemsListProvider);
      if (currentState.hasError) {
        final msg = const ErrorMapper().map(currentState.error!).message;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${item.name}" deleted successfully')),
        );
      }
      Navigator.of(context).pop(!currentState.hasError);
    }
  }
}
