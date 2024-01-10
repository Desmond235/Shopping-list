import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widget/grocery_list.dart';
import 'package:shopping_list/widget/new_item.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  final List<GroceryItem> _groceryItem = [];
  void _addItem() async {
    // gets the saved user input passed to the grocery item model
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    // adds the saved  user input to the grocery list item
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    _groceryItem.remove(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceris'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _groceryItem.isEmpty
          ? const Center(
              child: Text(
                'You\'ve got no items yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                // Displays the user input added to the grocery item list in the category screen
                return GroceryListItem(
                  groceryItem: _groceryItem[index],
                  onRemoveItem:() => _removeItem(_groceryItem[index]),
                );
              },
              itemCount: _groceryItem.length,
            ),
    );
  }
}
