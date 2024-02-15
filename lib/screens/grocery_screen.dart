import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widget/grocery_list.dart';
import 'package:shopping_list/widget/new_item.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<GroceryItem> _groceryItem = [];

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-app-eaf55-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);

    final Map<String, dynamic> listItems = json.decode(response.body);
    final List<GroceryItem> loadData = [];

    for (var item in listItems.entries) {
      final category = categories.entries
          .firstWhere(
            (categoryItem) =>
                categoryItem.value.title == item.value['category'],
          )
          .value;
          
      loadData.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category),
      );
    }

    setState(() {
      _groceryItem = loadData;
    });
  }

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

    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    final groceryIndex = _groceryItem.indexOf(item);
    setState(() {
      _groceryItem.remove(item);
    });
    
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Grocery item deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _groceryItem.insert(groceryIndex, item);
            });
          },
        ),
      ),
    );
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                // Displays the user input added to the grocery item list in the category screen
                return GroceryListItem(
                    groceryItem: _groceryItem[index],
                    onRemoveItem: (direction) {
                      _removeItem(_groceryItem[index]);
                    });
              },
              itemCount: _groceryItem.length,
            ),
    );
  }
}
