import 'package:budget_manager/pages/items_list/dto/item.dart';
import 'package:budget_manager/pages/items_list/repository/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//TODO: remove the back button from the app bar
class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({super.key});

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  List<Item> _items = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    GetIt.I
        .get<ItemRepository>()
        .fetchItems()
        .then((data) {
          setState(() {
            _items = data;
            _loading = false;
          });
        })
        .catchError((e) {
          setState(() {
            _error = e.toString();
            _loading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Error: $_error'))
          : _items.isEmpty
          ? const Center(child: Text('No items found'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final title = item.name;
                return ListTile(
                  title: Text(title),
                  subtitle: Text(item.description),
                  trailing: Text('${item.amount.toStringAsFixed(2)} KM'),
                );
              },
            ),
    );
  }
}
