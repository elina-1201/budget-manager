import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_manager/pages/items_list/dto/item.dart';
import 'package:budget_manager/pages/items_list/provider/item_provider.dart';

class ItemsListScreen extends ConsumerWidget {
  const ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (items) => items.isEmpty
            ? const Center(child: Text('No items yet, try adding some!'))
            : ItemsList(items: items),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_item');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.items});
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: Text('${item.amount.toStringAsFixed(2)} KM'),
        );
      },
    );
  }
}
