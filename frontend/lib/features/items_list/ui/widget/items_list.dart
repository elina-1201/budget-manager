import 'package:budget_manager/core/data/dto/item.dart';
import 'package:budget_manager/features/items_list/ui/widget/alert_on_delete.dart';
import 'package:budget_manager/features/items_list/ui/widget/item_tile.dart';
import 'package:flutter/material.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({super.key, required this.items});
  final List<Item> items;

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Dismissible(
          key: ValueKey(item.id),
          background: const DeleteBackground(),
          direction: DismissDirection.endToStart,
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertOnDelete(item: item);
              },
            );
          },
          child: ItemTile(item: item),
        );
      },
    );
  }
}
