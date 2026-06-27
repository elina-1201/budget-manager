import 'package:budget_manager/features/item_details/provider/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemDetailsScreen extends ConsumerWidget {
  final int itemId;
  const ItemDetailsScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(itemDetailsProvider(itemId));
    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: itemAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (item) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: ${item.name}'),
              Text('Description: ${item.description}'),
              Text('Amount: ${item.amount.toStringAsFixed(2)} KM'),
              Text('Category: ${item.category}'),
            ],
          ),
        ),
      ),
    );
  }
}
