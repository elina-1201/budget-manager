import 'package:budget_manager/features/add_item/provider/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

//FIXME: Refactor not to use legacy provider!
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class AddItemForm extends ConsumerStatefulWidget {
  const AddItemForm({super.key});

  @override
  ConsumerState<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends ConsumerState<AddItemForm> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categoryProvider.notifier).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: 'Item Name')),
          TextField(decoration: InputDecoration(labelText: 'Description')),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          SelectionDropDown(list: categories.map((c) => c.name).toList()),
          ElevatedButton(onPressed: () {}, child: Text('Add Item')),
        ],
      ),
    );
  }
}

class SelectionDropDown extends ConsumerStatefulWidget {
  final List<String> list;
  const SelectionDropDown({super.key, required this.list});

  @override
  ConsumerState<SelectionDropDown> createState() => _SelectionDropDownState();
}

class _SelectionDropDownState extends ConsumerState<SelectionDropDown> {
  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedCategoryProvider);

    return DropdownButton<String>(
      hint: const Text('Select category'),
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
      value: selected,
      onChanged: (String? value) {
        ref.read(selectedCategoryProvider.notifier).state = value;
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }
}
