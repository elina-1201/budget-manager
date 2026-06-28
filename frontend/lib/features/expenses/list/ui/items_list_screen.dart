import 'package:budget_manager/core/storage/auth_state_provider.dart';
import 'package:budget_manager/features/expenses/list/providers/item_list_notifier.dart';
import 'package:budget_manager/features/expenses/list/ui/items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemsListScreen extends ConsumerStatefulWidget {
  const ItemsListScreen({super.key});

  @override
  ConsumerState<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends ConsumerState<ItemsListScreen> {
  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        leading: IconButton(
          icon: Icon(Icons.logout_sharp),
          onPressed: () {
            ref.read(authStateProvider.notifier).logout();
          },
        ),
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (items) => items.isEmpty
            ? const Center(child: Text('No items yet, try adding some!'))
            : ItemsList(items: items),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/items/add_item');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
