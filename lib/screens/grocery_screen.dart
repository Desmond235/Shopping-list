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
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  void _loadItems() async {
    final url = Uri.https(
        'https://shopping-list-ce56f-default-rtdb.firebaseio.com',
        'shopping-list.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

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
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
          _error = 'Something went wrong! Please try again later.';
        });
    }
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

  void _removeItem(GroceryItem item) async {
    final groceryIndex = _groceryItem.indexOf(item);
    setState(() {
      _groceryItem.remove(item);
    });

    final url = Uri.https(
        'https://shopping-list-ce56f-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItem.insert(groceryIndex, item);
      });
    }
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
      body: _error != null
          ? Center(
              child: Text(_error!),
            )
          : _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _groceryItem.isEmpty
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
                          },
                        );
                      },
                      itemCount: _groceryItem.length,
                    ),
    );
  }
}
