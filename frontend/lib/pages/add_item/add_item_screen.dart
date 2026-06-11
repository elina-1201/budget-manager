import 'package:budget_manager/pages/add_item/widget/add_item_form.dart';
import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Item')),
      body: AddItemForm(),
    );
  }
}
