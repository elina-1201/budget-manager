import 'package:budget_manager/core/data/dto/item.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${item.name}'),
            Text('Description: ${item.description}'),
            Text('Amount: ${item.amount.toStringAsFixed(2)} KM'),
          ],
        ),
      ),
    );
  }
}
